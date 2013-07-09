require 'spec_helper'

describe MWS::API::Products do

  let(:connection) {MWS::Connection.new({
    aws_access_key_id: "access key",
    aws_secret_access_key: "secret key",
    seller_id: "seller id"
  })}

  let(:orders) {MWS::API::Products.new(connection)}

  it "should inheritance from MWS::API::Base" do
    MWS::API::Products.superclass.should eq(MWS::API::Base)
  end

  it "should set the right :uri" do
    orders.uri.should eq("/Products/2011-10-01")
  end

  it "should set the right :version" do
    orders.version.should eq("2011-10-01")
  end
end
