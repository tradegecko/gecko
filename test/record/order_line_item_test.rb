require 'test_helper'

class Gecko::OrderLineItemTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  def setup
    @json = load_vcr_hash("order_line_items", "order_line_items").first
    @record = Gecko::Record::OrderLineItem.new(Gecko::Client.new("ABC", "DEF"), @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::OrderLineItem, @record)
  end
end
