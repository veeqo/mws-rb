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
    before(:each) { allow(HTTParty).to receive(:get).and_return(result) }

    context 'regular method call' do
      let(:result) { {} }

      it 'should raise exception if Actions do not contain the action name' do
        expect { test_api.action_not_found }.to raise_error(NoMethodError)
      end

      it 'makes api call and return result if Actions contain the action name' do
        expect(test_api.test_action).to eq result
      end

      context 'displaying warnings' do
        subject { test_api.test_action }

        before do
          @original_display_warnings = MWS.display_warnings
          MWS.config { |config| config.display_warnings = display_warnings }
        end

        after do
          subject
          MWS.config { |config| config.display_warnings = @original_display_warnings }
        end

        context 'is true' do
          let(:display_warnings) { true }

          let(:expected_deprication_warning) do
            '[WARNING] `test_action` will have the same functionality as `test_action!` ' \
            "in the next major version.\n"
          end

          it 'prints a deprication warning' do
            expect { subject }
              .to output(expected_deprication_warning)
              .to_stderr
          end
        end

        context 'is false' do
          let(:display_warnings) { false }

          it 'prints nothing' do
            expect { subject }.not_to output.to_stderr
          end
        end
      end
    end

    context 'bang method' do
      context 'API response does not contain errors' do
        let(:result) { {} }

        it 'raises exception if Actions do not contain the action name' do
          expect { test_api.action_not_found! }.to raise_error(NoMethodError)
        end

        it 'makes api call and return result if Actions contain the action name' do
          expect(test_api.test_action!).to eq result
        end
      end

      context 'API response contains errors' do
        let(:result) { { 'ErrorResponse' => {} } }

        it 'makes api call and returns error' do
          expect { test_api.test_action! }
            .to raise_error MWS::API::ResponseError, '{"ErrorResponse":{}}'
        end
      end
    end
  end

  describe '#respond_to_missing?' do
    subject { test_api.respond_to?(method_name) }

    context 'Actions contain method' do
      let(:method_name) { 'test_action' }

      it { is_expected.to be true }
    end

    context 'Actions do not contain method' do
      let(:method_name) { 'missed_test_action' }

      it { is_expected.to be false }
    end

    context 'Actions contain bang method' do
      let(:method_name) { 'test_action!' }

      it { is_expected.to be true }
    end

    context 'Actions do not contain bang method' do
      let(:method_name) { 'missed_test_action!' }

      it { is_expected.to be false }
    end

    context 'regular Ruby method' do
      let(:method_name) { 'nil?' }

      it { is_expected.to be true }
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
