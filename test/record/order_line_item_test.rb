require 'test_helper'

class Gecko::OrderLineItemTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "order_line_items" }
  let(:record_class)  { Gecko::Record::OrderLineItem }

  def setup
    @json   = load_vcr_hash("order_line_items", "order_line_items").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::OrderLineItem, @record)
  end
end
