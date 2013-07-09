require 'spec_helper'

describe MWS::API::Base do
  let(:connection) {MWS::Connection.new({
    aws_access_key_id: "access key",
    aws_secret_access_key: "secret key",
    seller_id: "seller id"
  })}

  let(:base) {MWS::API::Base.new(connection)}

  it "hould receive a connection object" do
    base.connection.should eq(connection)
  end

  it "should respond to .call" do
    base.should respond_to(:call)
  end

  it "should respond to :uri and :version" do
    base.should respond_to(:uri)
    base.should respond_to(:version)
  end
end
