require 'spec_helper'

describe MWS::API::Subscriptions do
  let(:connection) do
    MWS::Connection.new(aws_access_key_id: 'access key',
                        aws_secret_access_key: 'secret key',
                        seller_id: 'seller id',
                        mws_auth_token: 'auth token')
  end

  let(:subscriptions) { MWS::API::Subscriptions.new(connection) }

  it 'should inheritance from MWS::API::Base' do
    expect(MWS::API::Subscriptions.superclass).to eq(MWS::API::Base)
  end

  it 'should set the right :uri' do
    expect(subscriptions.uri).to eq('/Subscriptions/2013-07-01')
  end

  it 'should set the right :version' do
    expect(subscriptions.version).to eq('2013-07-01')
  end
end
