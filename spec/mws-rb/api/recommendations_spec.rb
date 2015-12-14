require 'spec_helper'

describe MWS::API::Recommendations do
  let(:connection) do
    MWS::Connection.new(aws_access_key_id: 'access key',
                        aws_secret_access_key: 'secret key',
                        seller_id: 'seller id',
                        mws_auth_token: 'auth token')
  end

  let(:recommendations) { MWS::API::Recommendations.new(connection) }

  it 'should inheritance from MWS::API::Base' do
    expect(MWS::API::Recommendations.superclass).to eq(MWS::API::Base)
  end

  it 'should set the right :uri' do
    expect(recommendations.uri).to eq('/Recommendations/2013-04-01')
  end

  it 'should set the right :version' do
    expect(recommendations.version).to eq('2013-04-01')
  end
end
