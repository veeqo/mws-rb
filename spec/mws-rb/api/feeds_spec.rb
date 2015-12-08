require 'spec_helper'

describe MWS::API::Feeds do
  let(:connection) {MWS::Connection.new({
    aws_access_key_id: "access key",
    aws_secret_access_key: "secret key",
    seller_id: "seller id",
    mws_auth_token: 'auth token'
  })}

  let(:feeds) {MWS::API::Feeds.new(connection)}

  it "should inheritance from MWS::API::Base" do
    expect(MWS::API::Feeds.superclass).to eq(MWS::API::Base)
  end

  it "should set the right :uri" do
    expect(feeds.uri).to eq("/")
  end

  it "should set the right :version" do
    expect(feeds.version).to eq("2009-01-01")
  end

  describe "#submit_feed" do
    let(:mws_api) {
      MWS.new(
        host: "mws-eu.amazonservices.com",
        aws_access_key_id: ENV['AWS_ACCESS_KEY'] || 'DUMMY_AWS_ACCESS_KEY',
        aws_secret_access_key: ENV['AWS_SECRET_KEY'] || 'DUMMY_AWS_SECRET_KEY',
        seller_id: ENV['AWS_SELLER_ID'] || 'DUMMY_AWS_SELLER_ID'
      )
    }

    subject { mws_api.feeds.submit_feed(feed_data) }

    context "with xml request", vcr: { cassette_name: 'feeds/submit_feed/xml_request' } do
      let(:feed_data) {
        {
          feed_type: "_POST_INVENTORY_AVAILABILITY_DATA_",
          message_type: :inventory,
          messages: [
            {
              "MessageID" => (Time.now.to_i * rand).ceil.to_s,
              "OperationType" => "Update",
              "Inventory" => {
                "SKU" => 'LG-WHITE-1389247',
                "Quantity" => '9'
              }
            }
          ]
        }
      }

      it 'returns a kind of hash' do
        expect(subject).to be_kind_of(Hash)
      end
    end

    context "with text request", vcr: { cassette_name: 'feeds/submit_feed/text_request' } do
      let(:feed_data) {
        {
          feed_type: "_POST_FLAT_FILE_INVLOADER_DATA_",
          type: 'text',
          message: "sku\tquantity\nLG-WHITE-1389247\t9"
        }
      }

      it 'returns a kind of hash' do
        expect(subject).to be_kind_of(Hash)
      end
    end

    context "with invalid request", vcr: { cassette_name: 'feeds/submit_feed/invalid_request' } do
      let(:feed_data) {
        {
          # feed_type is missed
          type: 'text',
          message: "sku\tquantity\nLG-WHITE-1389247\t9"
        }
      }

      it 'returns a kind of hash' do
        expect(subject).to be_kind_of(Hash)
      end
    end
  end
end
