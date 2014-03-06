require 'test_helper'

class Gecko::FulfillmentLineItemTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "fulfillment_line_items" }
  let(:record_class)  { Gecko::Record::FulfillmentLineItem }

  def setup
    @json   = load_vcr_hash("fulfillments", "fulfillment_line_items").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::FulfillmentLineItem, @record)
  end
end
