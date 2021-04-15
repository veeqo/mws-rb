require 'spec_helper'

describe MWS::API::Feeds::Envelope, 'built _POST_ORDER_FULFILLMENT_DATA_ feed' do
  subject { described_class.new(params) }

  let(:params) do
    {
      feed_type: '_POST_ORDER_FULFILLMENT_DATA_',
      message_type: message_type,
      message: {
        'MessageID' => '123123123',
        'OrderFulfillment' => {
          'AmazonOrderID' => '123-3333333-4444444',
          'FulfillmentDate' => '2020-12-08T15:23:47Z',
          'FulfillmentData' => fulfillment_data,
          'CODCollectionMethod' => 'DirectPayment',
          'Items' => [
            { 'AmazonOrderItemCode' => '13131313131313', 'MerchantFulfillmentItemID' => '12345678912345', 'Quantity' => '1', 'TransparencyCode' => '123456789011' },
            { 'AmazonOrderItemCode' => '13131313131313', 'MerchantFulfillmentItemID' => '12345678911111', 'Quantity' => '2', 'TransparencyCode' => '123456789012' }
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
  let(:message_type) { :order_fulfillment }

  context 'when carrier code and carrier name combinations are valid' do
    context 'when supported carrier code is passed' do
      let(:fulfillment_data) do
        {
          'CarrierCode' => 'DHL',
          'ShippingMethod' => 'TruckDelivery',
          'ShipperTrackingNumber' => '123456789'
        }
      end
      let(:expected_value) do
        "<AmazonEnvelope><Header><DocumentVersion>1.01</DocumentVersion><MerchantIdentifier/></Header><MessageType>OrderFulfillment</MessageType><PurgeAndReplace>false</PurgeAndReplace><Message> <MessageID>123123123</MessageID> <OrderFulfillment> <AmazonOrderID>123-3333333-4444444</AmazonOrderID> <FulfillmentDate>2020-12-08T15:23:47Z</FulfillmentDate> <FulfillmentData> <CarrierCode>DHL</CarrierCode> <ShippingMethod>TruckDelivery</ShippingMethod> <ShipperTrackingNumber>123456789</ShipperTrackingNumber> </FulfillmentData> <CODCollectionMethod>DirectPayment</CODCollectionMethod> <Item> <AmazonOrderItemCode>13131313131313</AmazonOrderItemCode> <MerchantFulfillmentItemID>12345678912345</MerchantFulfillmentItemID> <Quantity>1</Quantity> <TransparencyCode>123456789011</TransparencyCode> </Item> <Item> <AmazonOrderItemCode>13131313131313</AmazonOrderItemCode> <MerchantFulfillmentItemID>12345678911111</MerchantFulfillmentItemID> <Quantity>2</Quantity> <TransparencyCode>123456789012</TransparencyCode> </Item> <ShipFromAddress> <Name>Berlin Address</Name> <AddressFieldOne>572 Brett Knolls</AddressFieldOne> <AddressFieldTwo>Apt. 064</AddressFieldTwo> <City>West Antoinebury</City> <StateOrRegion>Kent</StateOrRegion> <PostalCode>GA6 8HS</PostalCode> <CountryCode>GB</CountryCode> </ShipFromAddress> </OrderFulfillment> </Message> </AmazonEnvelope>"
      end

      it { expect(subject).to be_valid }

      it 'has proper data' do
        expect(subject.to_s.squish).to include(expected_value)
      end
    end

    context 'when carrier code value is "Other"' do
      let(:fulfillment_data) do
        {
          'CarrierCode' => 'Other',
          'CarrierName' => 'UK Mail',
          'ShippingMethod' => 'TruckDelivery',
          'ShipperTrackingNumber' => '123456789'
        }
      end
      let(:expected_value) do
        "<AmazonEnvelope><Header><DocumentVersion>1.01</DocumentVersion><MerchantIdentifier/></Header><MessageType>OrderFulfillment</MessageType><PurgeAndReplace>false</PurgeAndReplace><Message> <MessageID>123123123</MessageID> <OrderFulfillment> <AmazonOrderID>123-3333333-4444444</AmazonOrderID> <FulfillmentDate>2020-12-08T15:23:47Z</FulfillmentDate> <FulfillmentData> <CarrierCode>Other</CarrierCode> <CarrierName>UK Mail</CarrierName> <ShippingMethod>TruckDelivery</ShippingMethod> <ShipperTrackingNumber>123456789</ShipperTrackingNumber> </FulfillmentData> <CODCollectionMethod>DirectPayment</CODCollectionMethod> <Item> <AmazonOrderItemCode>13131313131313</AmazonOrderItemCode> <MerchantFulfillmentItemID>12345678912345</MerchantFulfillmentItemID> <Quantity>1</Quantity> <TransparencyCode>123456789011</TransparencyCode> </Item> <Item> <AmazonOrderItemCode>13131313131313</AmazonOrderItemCode> <MerchantFulfillmentItemID>12345678911111</MerchantFulfillmentItemID> <Quantity>2</Quantity> <TransparencyCode>123456789012</TransparencyCode> </Item> <ShipFromAddress> <Name>Berlin Address</Name> <AddressFieldOne>572 Brett Knolls</AddressFieldOne> <AddressFieldTwo>Apt. 064</AddressFieldTwo> <City>West Antoinebury</City> <StateOrRegion>Kent</StateOrRegion> <PostalCode>GA6 8HS</PostalCode> <CountryCode>GB</CountryCode> </ShipFromAddress> </OrderFulfillment> </Message> </AmazonEnvelope>"
      end

      it { expect(subject).to be_valid }

      it 'has proper data' do
        expect(subject.to_s.squish).to include(expected_value)
      end
    end
  end

  context 'when carrier code and carrier name combinations are invalid' do
    context 'when unsupported carrier code is passed' do
      let(:fulfillment_data) do
        {
          'CarrierCode' => 'Wrong DHL',
          'ShippingMethod' => 'TruckDelivery',
          'ShipperTrackingNumber' => '123456789'
        }
      end

      it { expect { subject }.to raise_error(RuntimeError, /Invalid XML/i) }
    end

    context 'when supported carrier code is passed along with carrier name' do
      let(:fulfillment_data) do
        {
          'CarrierCode' => 'DHL',
          'CarrierName' => 'DHL 24 Hours',
          'ShippingMethod' => 'TruckDelivery',
          'ShipperTrackingNumber' => '123456789'
        }
      end

      it { expect { subject }.to raise_error(RuntimeError, /Invalid CarrierCode and CarrierName combination!/i) }
    end

    context 'when carrier code with value "Other" passed without any carrier name' do
      let(:fulfillment_data) do
        {
          'CarrierCode' => 'Other',
          'ShippingMethod' => 'TruckDelivery',
          'ShipperTrackingNumber' => '123456789'
        }
      end

      it { expect { subject }.to raise_error(RuntimeError, /Invalid CarrierCode and CarrierName combination!/i) }
    end

    context 'when only carrier name is passed' do
      let(:fulfillment_data) do
        {
          'CarrierName' => 'Other',
          'ShippingMethod' => 'TruckDelivery',
          'ShipperTrackingNumber' => '123456789'
        }
      end

      it { expect { subject }.to raise_error(RuntimeError, /Invalid CarrierCode and CarrierName combination!/i) }
    end

    context 'when message type is not `order_fulfillment`' do
      let(:fulfillment_data) do
        {
          'CarrierName' => 'Other',
          'ShippingMethod' => 'TruckDelivery',
          'ShipperTrackingNumber' => '123456789'
        }
      end
      let(:message_type) { :inventory }

      it { expect(subject).to be_valid }
    end
  end
end
