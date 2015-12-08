require 'spec_helper'

describe MWS::API::FulfillmentOutboundShipment do
  let(:connection) {MWS::Connection.new({
    aws_access_key_id: "access key",
    aws_secret_access_key: "secret key",
    seller_id: "seller id",
    mws_auth_token: 'auth token'
  })}

  let(:fulfillment_outbound_shipment) {MWS::API::FulfillmentOutboundShipment.new(connection)}

  it "should inheritance from MWS::API::Base" do
    expect(MWS::API::FulfillmentOutboundShipment.superclass).to eq(MWS::API::Base)
  end

  it "should set the right :uri" do
    expect(fulfillment_outbound_shipment.uri).to eq("/FulfillmentOutboundShipment/2010-10-01")
  end

  it "should set the right :version" do
    expect(fulfillment_outbound_shipment.version).to eq("2010-10-01")
  end
end
