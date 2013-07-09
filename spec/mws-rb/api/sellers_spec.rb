require 'spec_helper'

describe MWS::API::Sellers do

  let(:connection) {MWS::Connection.new({
    aws_access_key_id: "access key",
    aws_secret_access_key: "secret key",
    seller_id: "seller id"
  })}

  let(:sellers) {MWS::API::Sellers.new(connection)}

  it "should inheritance from MWS::API::Base" do
    MWS::API::Sellers.superclass.should eq(MWS::API::Base)
  end

  it "should set the right :uri" do
    sellers.uri.should eq("/Sellers/2011-07-01")
  end

  it "should set the right :version" do
    sellers.version.should eq("2011-07-01")
  end
end
