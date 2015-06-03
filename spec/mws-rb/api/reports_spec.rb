require 'spec_helper'

describe MWS::API::Reports do

  let(:connection) {MWS::Connection.new({
    aws_access_key_id: "access key",
    aws_secret_access_key: "secret key",
    seller_id: "seller id",
    mws_auth_token: 'auth token'
  })}

  let(:reports) {MWS::API::Reports.new(connection)}

  it "should inheritance from MWS::API::Base" do
    MWS::API::Reports.superclass.should eq(MWS::API::Base)
  end

  it "should set the right :uri" do
    reports.uri.should eq("/")
  end

  it "should set the right :version" do
    reports.version.should eq("2009-01-01")
  end
end
