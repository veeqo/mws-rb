require 'spec_helper'

describe MWS::API::Feeds::Envelope do
  it 'should validate the envelope' do
    expect do
      MWS::API::Feeds::Envelope.new(message_type: 'InvalidMessageType', message: { 'InvalidItem' => 'Invalid' })
    end.to raise_error RuntimeError
  end

  it 'accepts text based envelope' do
    expect(MWS::API::Feeds::Envelope.new(type: :text, message: 'test').to_s).to eq('test')
  end

  it 'should skip validation when param skip_schema_validation is true' do
    MWS::API::Feeds::Envelope.new(message_type: 'InvalidMessageType', message: { 'InvalidItem' => 'Invalid' }, skip_schema_validation: true)
  end

  it 'should remove array items' do
    envelope = MWS::API::Feeds::Envelope.new(
      message_type: 'InvalidMessageType',
      message: {
        'Items' => [{ item_1: '1' }, { item_2: '2' }],
        'Inventories' => [{ inventory_1: '1' }]
      },
      skip_schema_validation: true)

    expect(envelope.to_s.include?('Items')).to eq(false)
    expect(envelope.to_s.include?('Inventories')).to eq(false)
    expect(envelope.to_s.include?('array')).to eq(false)
  end
end
