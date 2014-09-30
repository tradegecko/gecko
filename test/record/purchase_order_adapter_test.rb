require 'test_helper'

class Gecko::Record::PurchaseOrderAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.PurchaseOrder }
  let(:plural_name)   { "purchase_orders" }
  let(:record_class)  { Gecko::Record::PurchaseOrder }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::PurchaseOrderAdapter, @client.PurchaseOrder)
  end
end