require 'spec_helper'

describe MWS::API::Reports do
  let(:connection) do
    MWS::Connection.new(aws_access_key_id: 'access key',
                        aws_secret_access_key: 'secret key',
                        seller_id: 'seller id',
                        mws_auth_token: 'auth token')
  end

  let(:reports) { MWS::API::Reports.new(connection) }

  it 'should inheritance from MWS::API::Base' do
    expect(MWS::API::Reports.superclass).to eq(MWS::API::Base)
  end

  it 'should set the right :uri' do
    expect(reports.uri).to eq('/')
  end

  it 'should set the right :version' do
    expect(reports.version).to eq('2009-01-01')
  end
end
