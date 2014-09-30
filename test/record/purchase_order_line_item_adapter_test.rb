require 'test_helper'

class Gecko::Record::PurchaseOrderLineItemAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.PurchaseOrderLineItem }
  let(:plural_name)   { "purchase_order_line_items" }
  let(:record_class)  { Gecko::Record::PurchaseOrderLineItem }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::PurchaseOrderLineItemAdapter, @client.PurchaseOrderLineItem)
  end
end
