require 'test_helper'

class Gecko::Record::OrderLineItemAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.OrderLineItem }
  let(:plural_name)   { 'order_line_items' }
  let(:record_class)  { Gecko::Record::OrderLineItem }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::OrderLineItemAdapter, @client.OrderLineItem)
  end

  def test_finding_many_order_line_items
    VCR.use_cassette('order_line_items_specific_count') do
      assert_equal(200, adapter.find_many((1..200).to_a).count)
    end
  end
end
