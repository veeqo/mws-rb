# frozen_string_literal: true

require 'spec_helper'

describe MWS::Auth do
  let(:instance_id) { 'instance_id' }
  let(:query_params) do
    {
      host: 'sellercentral.amazon.co.uk',
      uri: '/gp/mws/registration/register.html',
      aws_access_key_id: 'key',
      aws_secret_access_key: 'aaa',
      app_instance_id: instance_id,
      return_path: '/auth/oauth_callback?sessionId=123'
    }
  end

  let(:subject) { MWS::Auth.new(query_params) }

  describe '#initialize' do
    context 'when all params are passed' do
      it 'creates a MWS::Auth object' do
        expect(subject.class).to eq(MWS::Auth)
      end

      it 'has proper attributes' do
        expect(subject.uri).to eq('/gp/mws/registration/register.html')
        expect(subject.verb).to eq('GET')
        expect(subject.signature_method).to eq('HmacSHA256')
        expect(subject.signature_version).to eq(2)
        expect(subject.app_instance_id).to eq(instance_id)
        expect(subject.return_path).to eq('/auth/oauth_callback?sessionId=123')
      end
    end

    context 'when one of the required param is not passed' do
      let(:instance_id) { nil }

      it 'raises an exception' do
        expect { subject }.to raise_error(ArgumentError, 'You must provide [:host, :aws_access_key_id, :aws_secret_access_key, :app_instance_id, :return_path]')
      end
    end
  end

  describe '#signature' do
    let(:signature) { 'tZWw0DUGt4z8QFA25oB1xbxc9BpDrviFvGL88ImP6Mg=' }

    it 'generates a valid signature' do
      expect(subject.signature).to eq(signature)
    end
  end

  describe '#valid_signature?' do
    let(:signature) { 'nHcl/hJNjflFwcTKyd6eYQrjTYGHhF2bSvwkmGgOTJQ=' }
    let(:signed_string) { "POST\r\nhttps://www.vendor.com/mwsApp1\r\n/orders/listRecentOrders.jsp?sessionId=123\nAWSAccessKeyId=AKIAFJPPO5KLY6G4XO7Q&MWSAuthToken=amzn.mws.1234&Marketplace=ATVPDKIKX0DER&Merchant=A047950713KM6AGKQCBRD&SignatureMethod=HmacSHA256&SignatureVersion=2" }

    it 'returns true' do
      expect(
        subject.valid_signature?(
          signature: signature,
          signed_string: signed_string
        )
      ).to be_truthy
    end
  end

  describe '#authorization_url' do
    let(:auth_url) do
      'https://sellercentral.amazon.co.uk/gp/mws/registration/register.html?'\
      'AWSAccessKeyId=key&Signature=tZWw0DUGt4z8QFA25oB1xbxc9BpDrviFvGL88ImP6Mg%3D&'\
      'SignatureMethod=HmacSHA256&SignatureVersion=2&id=instance_id&'\
      'returnPathAndParameters=%2Fauth%2Foauth_callback%3FsessionId%3D123'
    end

    it 'returns valid authorization url' do
      expect(subject.authorization_url).to eq(auth_url)
    end
  end
end
