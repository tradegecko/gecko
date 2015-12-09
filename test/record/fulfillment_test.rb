require 'test_helper'

class Gecko::FulfillmentTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'fulfillments' }
  let(:record_class)  { Gecko::Record::Fulfillment }

  def setup
    @json   = load_vcr_hash('fulfillments', 'fulfillments').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Fulfillment, @record)
  end

  def test_serialization
    json_keys = %w(
      order_id shipping_address_id billing_address_id status stock_location_id exchange_rate
      delivery_type tracking_number notes tracking_url tracking_company packed_at
      service shipped_at received_at receipt
    ).map(&:to_sym)
    assert_equal json_keys.sort, @record.as_json[:fulfillment].keys.sort
  end
end
