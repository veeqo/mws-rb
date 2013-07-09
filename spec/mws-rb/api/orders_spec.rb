require 'spec_helper'

describe MWS::API::Orders do

  let(:connection) {MWS::Connection.new({
    aws_access_key_id: "access key",
    aws_secret_access_key: "secret key",
    seller_id: "seller id"
  })}

  let(:orders) {MWS::API::Orders.new(connection)}

  it "should inheritance from MWS::API::Base" do
    MWS::API::Orders.superclass.should eq(MWS::API::Base)
  end

  it "should set the right :uri" do
    orders.uri.should eq("/Orders/2011-01-01")
  end

  it "should set the right :version" do
    orders.version.should eq("2011-01-01")
  end
end
