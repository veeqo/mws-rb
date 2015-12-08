require 'spec_helper'

describe MWS::API::Sellers do

  let(:connection) {MWS::Connection.new({
    aws_access_key_id: "access key",
    aws_secret_access_key: "secret key",
    seller_id: "seller id",
    mws_auth_token: 'auth token'
  })}

  let(:sellers) {MWS::API::Sellers.new(connection)}

  it "should inheritance from MWS::API::Base" do
    expect(MWS::API::Sellers.superclass).to eq(MWS::API::Base)
  end

  it "should set the right :uri" do
    expect(sellers.uri).to eq("/Sellers/2011-07-01")
  end

  it "should set the right :version" do
    expect(sellers.version).to eq("2011-07-01")
  end

  it "should set the right :version" do
    expect(sellers.verb).to eq(:post)
  end
end
