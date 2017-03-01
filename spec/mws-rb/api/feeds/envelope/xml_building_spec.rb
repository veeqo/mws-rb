require 'spec_helper'

describe MWS::API::Feeds::Envelope, 'built xml' do
  subject { described_class.new(params) }

  context 'when passed message param' do
    let(:params) do
      { feed_type: '_POST_INVENTORY_AVAILABILITY_DATA_',
        message_type: :inventory,
        message: {
          'MessageID' => '123123123',
          'OperationType' => 'Update',
          'Inventory' => {
            'SKU' => 'ANY-SKU',
            'Quantity' => '50'
          } } }
    end

    it 'should contain passed data' do
      expect(subject.to_s).to include("<MessageType>Inventory</MessageType><PurgeAndReplace>false</PurgeAndReplace><Message>\n  <MessageID>123123123</MessageID>\n  <OperationType>Update</OperationType>\n  <Inventory>\n    <SKU>ANY-SKU</SKU>\n    <Quantity>50</Quantity>\n  </Inventory>\n</Message>")
    end

    it 'should be valid' do
      expect(subject).to be_valid
    end
  end

  context 'when passed \'messages\' param' do
    let(:params) do
      { feed_type: '_POST_INVENTORY_AVAILABILITY_DATA_',
        message_type: :inventory,
        messages: [
          {
            'MessageID' => '123123123',
            'OperationType' => 'Update',
            'Inventory' => {
              'SKU' => 'ANY-SKU',
              'Quantity' => '50'
            }
          },
          { 'MessageID' => '321321321',
            'OperationType' => 'Update',
            'Inventory' => {
              'SKU' => 'ANY-OTHER-SKU',
              'Quantity' => '10'
            }
          }] }
    end

    it 'should contain passed data of each message' do
      expect(subject.to_s).to include("<MessageType>Inventory</MessageType><PurgeAndReplace>false</PurgeAndReplace><Message>\n  <MessageID>123123123</MessageID>\n  <OperationType>Update</OperationType>\n  <Inventory>\n    <SKU>ANY-SKU</SKU>\n    <Quantity>50</Quantity>\n  </Inventory>\n</Message>")
      expect(subject.to_s).to include("<Message>\n  <MessageID>321321321</MessageID>\n  <OperationType>Update</OperationType>\n  <Inventory>\n    <SKU>ANY-OTHER-SKU</SKU>\n    <Quantity>10</Quantity>\n  </Inventory>\n</Message>")
    end

    it 'should be valid' do
      expect(subject).to be_valid
    end
  end

  context "when passed 'messages' param contains element with array value" do
    let(:params) do
      {
        merchant_id: 'A28GO50DFGJ0C3',
        feed_type: '_POST_ORDER_ACKNOWLEDGEMENT_DATA_',
        message_type: :order_acknowledgement,
        messages: {
          "MessageID" => '123123123',
          "OrderAcknowledgement" => {
            "AmazonOrderID" => '123-1234567-1234567',
            "StatusCode" => "Failure",
            "Items" => [
              { "AmazonOrderItemCode" => '12345678901234', "CancelReason" => "BuyerCanceled" },
              { "AmazonOrderItemCode" => '12345678909876', "CancelReason" => "CustomerReturn" }
            ]
          }
        }
      }
    end

    it 'should contain passed data' do
      expect(subject.to_s).to eq("<AmazonEnvelope><Header><DocumentVersion>1.01</DocumentVersion><MerchantIdentifier>A28GO50DFGJ0C3</MerchantIdentifier></Header><MessageType>OrderAcknowledgement</MessageType><PurgeAndReplace>false</PurgeAndReplace><Message>\n  <MessageID>123123123</MessageID>\n  <OrderAcknowledgement>\n    <AmazonOrderID>123-1234567-1234567</AmazonOrderID>\n    <StatusCode>Failure</StatusCode>\n    \n      <Item>\n        <AmazonOrderItemCode>12345678901234</AmazonOrderItemCode>\n        <CancelReason>BuyerCanceled</CancelReason>\n      </Item>\n      <Item>\n        <AmazonOrderItemCode>12345678909876</AmazonOrderItemCode>\n        <CancelReason>CustomerReturn</CancelReason>\n      </Item>\n    \n  </OrderAcknowledgement>\n</Message>\n</AmazonEnvelope>")
    end

    it 'should be valid' do
      expect(subject).to be_valid
    end
  end

  context 'when passed \'message\' and \'messages\'' do
    let(:multiple_messages) do
      { messages: [
        {
          'MessageID' => '123123123',
          'OperationType' => 'Update',
          'Inventory' => {
            'SKU' => 'ANY-SKU',
            'Quantity' => '50'
          }
        },
        { 'MessageID' => '321321321',
          'OperationType' => 'Update',
          'Inventory' => {
            'SKU' => 'ANY-OTHER-SKU',
            'Quantity' => '10'
          }
        }] }
    end

    let(:single_message) do
      { message: {
        'MessageID' => '987654321',
        'OperationType' => 'Update',
        'Inventory' => {
          'SKU' => 'SINGLE-SKU',
          'Quantity' => '20'
        } } }
    end

    let(:params) do
      { feed_type: '_POST_INVENTORY_AVAILABILITY_DATA_',
        message_type: :inventory }.merge(multiple_messages).merge(single_message)
    end

    it 'should contain info from all of these keys' do
      expect(subject.to_s).to include("<Message>\n  <MessageID>123123123</MessageID>\n  <OperationType>Update</OperationType>\n  <Inventory>\n    <SKU>ANY-SKU</SKU>\n    <Quantity>50</Quantity>\n  </Inventory>\n</Message>")
      expect(subject.to_s).to include("<Message>\n  <MessageID>321321321</MessageID>\n  <OperationType>Update</OperationType>\n  <Inventory>\n    <SKU>ANY-OTHER-SKU</SKU>\n    <Quantity>10</Quantity>\n  </Inventory>\n</Message>")
      expect(subject.to_s).to include("<Message>\n  <MessageID>987654321</MessageID>\n  <OperationType>Update</OperationType>\n  <Inventory>\n    <SKU>SINGLE-SKU</SKU>\n    <Quantity>20</Quantity>\n  </Inventory>\n</Message>")
    end
  end

  context "when passed 'messages' param element require some attributes" do
    let(:params) do
      {
        feed_type: '_POST_PRODUCT_PRICING_DATA_',
        message_type: :price,
        messages: [
          {
            'MessageID' => '123123123',
            'OperationType' => 'Update',
            'Price' => {
              'SKU' => 'ANY-SKU',
              'StandardPrice' => { '@currency' => 'USD', 'content' => '50' }
            }
          },
          { 'MessageID' => '321321321',
            'OperationType' => 'Update',
            'Price' => {
              'SKU' => 'ANY-OTHER-SKU',
              'StandardPrice' => { '@currency' => 'USD', 'content' => '10' }
            }
          }
        ]
      }
    end

    it 'should contain passed data' do
      expect(subject.to_s).to eq("<AmazonEnvelope><Header><DocumentVersion>1.01</DocumentVersion><MerchantIdentifier/></Header><MessageType>Price</MessageType><PurgeAndReplace>false</PurgeAndReplace><Message>\n  <MessageID>123123123</MessageID>\n  <OperationType>Update</OperationType>\n  <Price>\n    <SKU>ANY-SKU</SKU>\n    <StandardPrice currency=\"USD\">50</StandardPrice>\n  </Price>\n</Message>\n<Message>\n  <MessageID>321321321</MessageID>\n  <OperationType>Update</OperationType>\n  <Price>\n    <SKU>ANY-OTHER-SKU</SKU>\n    <StandardPrice currency=\"USD\">10</StandardPrice>\n  </Price>\n</Message>\n</AmazonEnvelope>")
    end

    it 'should be valid' do
      expect(subject).to be_valid
    end
  end
end
