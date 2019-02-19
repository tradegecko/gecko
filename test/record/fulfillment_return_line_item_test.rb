require 'test_helper'

class Gecko::FulfillmentReturnLineItemTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'fulfillment_line_items' }
  let(:record_class)  { Gecko::Record::FulfillmentReturnLineItem }

  def setup
    @json   = load_vcr_hash('fulfillments', 'fulfillment_line_items').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::FulfillmentReturnLineItem, @record)
  end
end
