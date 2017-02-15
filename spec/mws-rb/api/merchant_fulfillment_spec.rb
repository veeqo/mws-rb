require 'spec_helper'

describe MWS::API::MerchantFulfilllment do
  let(:connection) do
    MWS::Connection.new(aws_access_key_id: 'access key',
                        aws_secret_access_key: 'secret key',
                        seller_id: 'seller id',
                        mws_auth_token: 'auth token')
  end

  let(:merchant_fulfillment) { MWS::API::MerchantFulfilllment.new(connection) }

  it 'should inheritance from MWS::API::Base' do
    expect(MWS::API::MerchantFulfilllment.superclass).to eq(MWS::API::Base)
  end

  it 'should set the right :uri' do
    expect(merchant_fulfillment.uri).to eq('MerchantFulfillment/2015-06-01')
  end

  it 'should set the right :version' do
    expect(merchant_fulfillment.version).to eq('2015-06-01')
  end
end
