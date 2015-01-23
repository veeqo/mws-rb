require 'spec_helper'

describe MWS::API::Feeds::Envelope do
  it "should validate the envelope" do
    expect {
      MWS::API::Feeds::Envelope.new(message_type: "InvalidMessageType", message:{"InvalidItem" => "Invalid"})
    }.to raise_error
  end

  it "should skip validation when param skip_schema_validation is true" do
    expect {
      MWS::API::Feeds::Envelope.new(message_type: "InvalidMessageType", message:{"InvalidItem" => "Invalid"}, skip_schema_validation: true)
    }.to_not raise_error
  end

  it "should remove array items" do
    envelope = MWS::API::Feeds::Envelope.new(
                message_type: "InvalidMessageType", 
                message:{
                  "Items" => [{item_1: "1"}, {item_2: "2"}],
                  "Inventories" => [{inventory_1: "1"}]
                },
                skip_schema_validation: true)

    envelope.to_s.include?("Items").should == false
    envelope.to_s.include?("Inventories").should == false
    envelope.to_s.include?("array").should == false
  end
end
