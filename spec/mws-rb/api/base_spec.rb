require 'spec_helper'

describe MWS::API::Base do
  let(:connection) {MWS::Connection.new({
    aws_access_key_id: "access key",
    aws_secret_access_key: "secret key",
    seller_id: "seller id"
  })}

  let(:base) {MWS::API::Base.new(connection)}

  it "should receive a connection object" do
    base.connection.should eq(connection)
  end

  it "should respond to .call" do
    base.should respond_to(:call)
  end

  it "should respond to :uri and :version and :verb" do
    base.should respond_to(:uri)
    base.should respond_to(:version)
    base.should respond_to(:verb)
  end

  it "should set :verb to :get as default" do
    base.verb.should eq(:get)
  end

  describe "method_missing to call actions" do
    class TestApi < MWS::API::Base
      Actions = [:test_action]
      def initialize(connection)
        @uri = "/Products/2011-10-01"
        @version = "2011-10-01"
        super(connection)
      end
    end

    let(:test_api) {TestApi.new(connection)}
    before(:each) {HTTParty.stub(:get).and_return({})}

    it "should not raise exception if Actions contain the action name" do
      expect {test_api.test_action}.to_not raise_error
    end

    it "should raise exception if Actions do not contain the action name" do
      expect {test_api.action_not_found}.to raise_error
    end
  end
end
