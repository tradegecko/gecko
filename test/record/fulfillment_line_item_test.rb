require 'test_helper'

class Gecko::FulfillmentLineItemTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  def setup
    @json = load_vcr_hash("fulfillments", "fulfillment_line_items").first
    @record = Gecko::Record::FulfillmentLineItem.new(Gecko::Client.new("ABC", "DEF"), @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::FulfillmentLineItem, @record)
  end
end
