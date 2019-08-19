require 'spec_helper'

describe MWS do
  describe '#new' do
    it 'returns a connection on initializer' do
      expect(subject.new(
        aws_access_key_id: 'access key',
        aws_secret_access_key: 'secret key',
        seller_id: 'seller id',
        mws_auth_token: 'auth token'
      ).class).to eq(MWS::Connection)
    end
  end

  describe '#auth' do
    it 'returns an auth object' do
      expect(subject.auth(
        aws_access_key_id: 'access_key',
        aws_secret_access_key: 'secret_key',
        host: 'sellercentral.amazon.com',
        app_instance_id: 'app_instance_id',
        return_path: 'return_path'
      ).class).to eq(MWS::Auth)
    end
  end
end
