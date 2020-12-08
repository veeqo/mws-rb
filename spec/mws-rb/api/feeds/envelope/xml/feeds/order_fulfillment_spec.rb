require 'spec_helper'

describe MWS::API::Feeds::Envelope, 'built _POST_ORDER_FULFILLMENT_DATA_ feed' do
  subject { described_class.new(params) }

  context 'when passed message param' do
    let(:params) do
      {
        feed_type: '_POST_ORDER_FULFILLMENT_DATA_',
        message_type: :order_fulfillment,
        message: {
          'MessageID' => '123123123',
          'OrderFulfillment' => {
            'AmazonOrderID' => '123-3333333-4444444',
            'FulfillmentDate' => '2020-12-08T15:23:47Z',
            'FulfillmentData' => {
              'CarrierName' => 'Other',
              'ShippingMethod' => 'TruckDelivery',
              'ShipperTrackingNumber' => '123456789'
            },
            'Items' => [
              { 'AmazonOrderItemCode' => '13131313131313', 'Quantity' => '1' },
              { 'AmazonOrderItemCode' => '13131313131313', 'Quantity' => '2' }
            ],
            'ShipFromAddress' => {
              'Name' => 'Berlin Address',
              'AddressFieldOne' => '572 Brett Knolls',
              'AddressFieldTwo' => 'Apt. 064',
              'City' => 'West Antoinebury',
              'StateOrRegion' => 'Kent',
              'PostalCode' => 'GA6 8HS',
              'CountryCode' => 'GB'
            }
          }
        }
      }
    end

    it { expect(subject).to be_valid }

    it 'contains passed data' do
      expect(subject.to_s.squish).to include(
        "<AmazonEnvelope><Header><DocumentVersion>1.01</DocumentVersion><MerchantIdentifier/></Header><MessageType>OrderFulfillment</MessageType><PurgeAndReplace>false</PurgeAndReplace><Message> <MessageID>123123123</MessageID> <OrderFulfillment> <AmazonOrderID>123-3333333-4444444</AmazonOrderID> <FulfillmentDate>2020-12-08T15:23:47Z</FulfillmentDate> <FulfillmentData> <CarrierName>Other</CarrierName> <ShippingMethod>TruckDelivery</ShippingMethod> <ShipperTrackingNumber>123456789</ShipperTrackingNumber> </FulfillmentData> <Item> <AmazonOrderItemCode>13131313131313</AmazonOrderItemCode> <Quantity>1</Quantity> </Item> <Item> <AmazonOrderItemCode>13131313131313</AmazonOrderItemCode> <Quantity>2</Quantity> </Item> <ShipFromAddress> <Name>Berlin Address</Name> <AddressFieldOne>572 Brett Knolls</AddressFieldOne> <AddressFieldTwo>Apt. 064</AddressFieldTwo> <City>West Antoinebury</City> <StateOrRegion>Kent</StateOrRegion> <PostalCode>GA6 8HS</PostalCode> <CountryCode>GB</CountryCode> </ShipFromAddress> </OrderFulfillment> </Message> </AmazonEnvelope>"
      )
    end
  end
end
