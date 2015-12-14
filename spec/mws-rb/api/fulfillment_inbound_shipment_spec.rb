require 'spec_helper'

describe MWS::API::FulfillmentInboundShipment do
  let(:connection) do
    MWS::Connection.new(aws_access_key_id: 'access key',
                        aws_secret_access_key: 'secret key',
                        seller_id: 'seller id',
                        mws_auth_token: 'auth token')
  end

  let(:fulfillment_inbound_shipment) { MWS::API::FulfillmentInboundShipment.new(connection) }

  it 'should inheritance from MWS::API::Base' do
    expect(MWS::API::Feeds.superclass).to eq(MWS::API::Base)
  end

  it 'should set the right :uri' do
    expect(fulfillment_inbound_shipment.uri).to eq('/FulfillmentInboundShipment/2010-10-01')
  end

  it 'should set the right :version' do
    expect(fulfillment_inbound_shipment.version).to eq('2010-10-01')
  end
end
