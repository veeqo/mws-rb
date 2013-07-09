require 'spec_helper'

describe MWS::API::Feeds do
  let(:connection) {MWS::Connection.new({
    aws_access_key_id: "access key",
    aws_secret_access_key: "secret key",
    seller_id: "seller id"
  })}

  let(:feeds) {MWS::API::Feeds.new(connection)}

  it "should inheritance from MWS::API::Base" do
    MWS::API::Feeds.superclass.should eq(MWS::API::Base)
  end

  it "should set the right :uri" do
    feeds.uri.should eq("/")
  end

  it "should set the right :version" do
    feeds.version.should eq("2009-01-01")
  end
end
