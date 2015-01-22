require 'spec_helper'

describe MWS::API::Subscriptions do
  let(:connection) {MWS::Connection.new({
    aws_access_key_id: "access key",
    aws_secret_access_key: "secret key",
    seller_id: "seller id"
  })}

  let(:subscriptions) {MWS::API::Subscriptions.new(connection)}

  it "should inheritance from MWS::API::Base" do
    MWS::API::Subscriptions.superclass.should eq(MWS::API::Base)
  end

  it "should set the right :uri" do
    subscriptions.uri.should eq("/Subscriptions/2013-07-01")
  end

  it "should set the right :version" do
    subscriptions.version.should eq("2013-07-01")
  end
end