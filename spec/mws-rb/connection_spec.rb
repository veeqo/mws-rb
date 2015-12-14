require 'spec_helper'

describe MWS::Connection do
  let(:subject) do
    MWS::Connection.new(aws_access_key_id: 'access key',
                        aws_secret_access_key: 'secret key',
                        seller_id: 'seller id',
                        mws_auth_token: 'auth token')
  end

  it 'should have a default host' do
    expect(subject.host).to eq('mws.amazonservices.com')
  end

  describe 'call the right apis' do
    it 'should return Feeds when calling .feeds' do
      expect(subject.feeds.instance_of?(MWS::API::Feeds)).to eq(true)
    end

    it 'should return FulfillmentInboundShipment' do
      expect(
        subject.fulfillment_inbound_shipment
        .instance_of?(MWS::API::FulfillmentInboundShipment)
      ).to eq(true)
    end

    it 'should return FulfillmentInventory' do
      expect(
        subject.fulfillment_inventory
        .instance_of?(MWS::API::FulfillmentInventory)
      ).to eq(true)
    end

    it 'should return FulfillmentOutboundShipment' do
      expect(
        subject.fulfillment_outbound_shipment
        .instance_of?(MWS::API::FulfillmentOutboundShipment)
      ).to eq(true)
    end

    it 'should return Orders when calling .orders' do
      expect(subject.orders.instance_of?(MWS::API::Orders)).to eq(true)
    end

    it 'should return Products when calling .products' do
      expect(subject.products.instance_of?(MWS::API::Products)).to eq(true)
    end

    it 'should return Recommendations when calling .recommendations' do
      expect(
        subject.recommendations
        .instance_of?(MWS::API::Recommendations)
      ).to eq(true)
    end

    it 'should return Reports when calling .reports' do
      expect(subject.reports.instance_of?(MWS::API::Reports)).to eq(true)
    end

    it 'should return Sellers when calling .sellers' do
      expect(subject.sellers.instance_of?(MWS::API::Sellers)).to eq(true)
    end
  end

  describe 'Validations' do
    it 'should raise argument error when no key, secret or seller_id' do
      expect { MWS::Connection.new }.to raise_error(ArgumentError)
    end

    it 'default aws_key/aws_secret/mws_auth_token from ENV' do
      ENV['AWS_ACCESS_KEY_ID'] = 'foo'
      ENV['AWS_SECRET_ACCESS_KEY'] = 'bar'
      ENV['MWS_AUTH_TOKEN'] = 'foobar'
      expect { MWS::Connection.new(seller_id: 'id') }.to_not raise_error
    end
  end
end
