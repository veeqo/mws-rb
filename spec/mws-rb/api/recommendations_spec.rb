require 'spec_helper'

describe MWS::API::Recommendations do

  let(:connection) {MWS::Connection.new({
    aws_access_key_id: "access key",
    aws_secret_access_key: "secret key",
    seller_id: "seller id",
    mws_auth_token: 'auth token'
  })}

  let(:recommendations) {MWS::API::Recommendations.new(connection)}

  it "should inheritance from MWS::API::Base" do
    MWS::API::Recommendations.superclass.should eq(MWS::API::Base)
  end

  it "should set the right :uri" do
    recommendations.uri.should eq("/Recommendations/2013-04-01")
  end

  it "should set the right :version" do
    recommendations.version.should eq("2013-04-01")
  end
end
