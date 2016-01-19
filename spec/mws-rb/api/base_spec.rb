require 'spec_helper'

describe MWS::API::Base do
  let(:connection) do
    MWS::Connection.new(aws_access_key_id: 'access key',
                        aws_secret_access_key: 'secret key',
                        seller_id: 'seller id',
                        mws_auth_token: 'auth token')
  end

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
    class TestApi < MWS::API::Base
      ACTIONS = [:test_action].freeze
      def initialize(connection)
        @uri = '/Products/2011-10-01'
        @version = '2011-10-01'
        super(connection)
      end
    end

    let(:test_api) { TestApi.new(connection) }
    before(:each) { allow(HTTParty).to receive(:get).and_return({}) }

    it 'should raise exception if Actions do not contain the action name' do
      expect { test_api.action_not_found }.to raise_error(NoMethodError)
    end
  end
end
