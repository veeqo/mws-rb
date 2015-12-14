require 'spec_helper'

describe MWS::API::Products do
  let(:connection) do
    MWS::Connection.new(aws_access_key_id: 'access key',
                        aws_secret_access_key: 'secret key',
                        seller_id: 'seller id',
                        mws_auth_token: 'auth token')
  end

  let(:orders) { MWS::API::Products.new(connection) }

  it 'should inheritance from MWS::API::Base' do
    expect(MWS::API::Products.superclass).to eq(MWS::API::Base)
  end

  it 'should set the right :uri' do
    expect(orders.uri).to eq('/Products/2011-10-01')
  end

  it 'should set the right :version' do
    expect(orders.version).to eq('2011-10-01')
  end
end
