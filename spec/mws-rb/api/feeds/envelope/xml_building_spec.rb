require 'spec_helper'

describe MWS::API::Feeds::Envelope, 'built xml' do
  subject { described_class.new(params) }

  context 'when passed message param' do
    let(:params) { { feed_type: "_POST_INVENTORY_AVAILABILITY_DATA_",
                     message_type: :inventory,
                     message: {
                      "MessageID" => '123123123',
                      "OperationType" => "Update",
                      "Inventory" => {
                        "SKU" => "ANY-SKU",
                        "Quantity"=>"50"
                      } } } }

    it 'should contain passed data' do
      subject.to_s.should include("<MessageType>Inventory</MessageType><PurgeAndReplace>false</PurgeAndReplace><Message>\n  <MessageID>123123123</MessageID>\n  <OperationType>Update</OperationType>\n  <Inventory>\n    <SKU>ANY-SKU</SKU>\n    <Quantity>50</Quantity>\n  </Inventory>\n</Message>")
    end

    it 'should be valid' do
      subject.should be_valid
    end
  end

  context 'when passed \'messages\' param' do
    let(:params) { { feed_type: "_POST_INVENTORY_AVAILABILITY_DATA_",
                     message_type: :inventory,
                     messages: [
                      {
                        "MessageID" => '123123123',
                        "OperationType" => "Update",
                        "Inventory" => {
                          "SKU" => "ANY-SKU",
                          "Quantity"=>"50"
                        }
                      },
                      { "MessageID" => '321321321',
                        "OperationType" => "Update",
                        "Inventory" => {
                          "SKU" => "ANY-OTHER-SKU",
                          "Quantity"=>"10"
                        }
                      } ] } }

    it 'should contain passed data of each message' do
      subject.to_s.should include("<MessageType>Inventory</MessageType><PurgeAndReplace>false</PurgeAndReplace><Message>\n  <MessageID>123123123</MessageID>\n  <OperationType>Update</OperationType>\n  <Inventory>\n    <SKU>ANY-SKU</SKU>\n    <Quantity>50</Quantity>\n  </Inventory>\n</Message>")
      subject.to_s.should include("<Message>\n  <MessageID>321321321</MessageID>\n  <OperationType>Update</OperationType>\n  <Inventory>\n    <SKU>ANY-OTHER-SKU</SKU>\n    <Quantity>10</Quantity>\n  </Inventory>\n</Message>")
    end

    it 'should be valid' do
      subject.should be_valid
    end
  end

  context 'when passed \'message\' and \'messages\'' do
    let(:multiple_messages) { { messages: [
                                  {
                                    "MessageID" => '123123123',
                                    "OperationType" => "Update",
                                    "Inventory" => {
                                      "SKU" => "ANY-SKU",
                                      "Quantity"=>"50"
                                    }
                                  },
                                  { "MessageID" => '321321321',
                                    "OperationType" => "Update",
                                    "Inventory" => {
                                      "SKU" => "ANY-OTHER-SKU",
                                      "Quantity"=>"10"
                                    }
                                  } ] } }

    let(:single_message) { { message: {
                               "MessageID" => '987654321',
                               "OperationType" => "Update",
                               "Inventory" => {
                                 "SKU" => "SINGLE-SKU",
                                 "Quantity"=>"20"
                               } } } }

    let(:params) { { feed_type: "_POST_INVENTORY_AVAILABILITY_DATA_",
                     message_type: :inventory }.merge(multiple_messages).merge(single_message) }

    it 'should contain info from all of these keys' do
      subject.to_s.should include("<Message>\n  <MessageID>123123123</MessageID>\n  <OperationType>Update</OperationType>\n  <Inventory>\n    <SKU>ANY-SKU</SKU>\n    <Quantity>50</Quantity>\n  </Inventory>\n</Message>")
      subject.to_s.should include("<Message>\n  <MessageID>321321321</MessageID>\n  <OperationType>Update</OperationType>\n  <Inventory>\n    <SKU>ANY-OTHER-SKU</SKU>\n    <Quantity>10</Quantity>\n  </Inventory>\n</Message>")
      subject.to_s.should include("<Message>\n  <MessageID>987654321</MessageID>\n  <OperationType>Update</OperationType>\n  <Inventory>\n    <SKU>SINGLE-SKU</SKU>\n    <Quantity>20</Quantity>\n  </Inventory>\n</Message>")
    end
  end
end
