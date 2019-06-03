require 'spec_helper'

describe MWS::API::Base do
  class TestApi < MWS::API::Base
    ACTIONS = [:test_action].freeze

    def initialize(connection)
      @uri = '/Products/2011-10-01'
      @version = '2011-10-01'
      super(connection)
    end
  end

  let(:connection) do
    MWS::Connection.new(aws_access_key_id: 'access key',
                        aws_secret_access_key: 'secret key',
                        seller_id: 'seller id',
                        mws_auth_token: 'auth token')
  end

  let(:test_api) { TestApi.new(connection) }
  let(:base) { MWS::API::Base.new(connection) }

  it 'should receive a connection object' do
    expect(base.connection).to eq(connection)
  end

  it 'should respond to .call' do
    expect(base).to respond_to(:call)
  end

  it 'should respond to :uri and :version and :verb' do
    expect(base).to respond_to(:uri)
    expect(base).to respond_to(:version)
    expect(base).to respond_to(:verb)
  end

  it 'should set :verb to :get as default' do
    expect(base.verb).to eq(:get)
  end

  describe 'method_missing to call actions' do
    before(:each) { allow(HTTParty).to receive(:get).and_return({}) }

    it 'should raise exception if Actions do not contain the action name' do
      expect { test_api.action_not_found }.to raise_error(NoMethodError)
    end
  end

  context 'user agent' do
    subject { test_api.test_action(params) }

    before do |example|
      @original_user_agent = MWS.user_agent
      MWS.config { |config| config.user_agent = user_agent }
    end

    after do
      subject
      MWS.config { |config| config.user_agent = @original_user_agent }
    end

    let(:params) { {} }

    context 'presents in configuration' do
      let(:user_agent) { 'My Seller Tool/2.0 (Language=Java/1.6.0.11; Platform=Windows/XP' }

      it 'User-Agent is passed' do
        expect(HTTParty).to receive(:get) do |_uri, params|
          expect(params[:headers]['User-Agent']).to eq user_agent
        end
      end

      context 'other header params presents as well' do
        let(:params) { { request_params: { headers: { 'Content-Type' => 'text/xml' } } } }

        before { test_api.instance_variable_set(:@verb, :post) }

        it 'merges all header params' do
          expect(HTTParty).to receive(:post) do |_uri, params|
            params.fetch(:headers).tap do |headers|
              expect(headers.fetch('User-Agent')).to eq user_agent
              expect(headers.fetch('Content-Type')).to eq 'text/xml'
            end
          end
        end
      end
    end

    context 'is not present in configuration' do
      let(:user_agent) { nil }

      it 'headers are not passed' do
        expect(HTTParty).to receive(:get) do |_uri, params|
          expect(params.key?(:headers)).to be false
        end
      end
    end
  end
end
