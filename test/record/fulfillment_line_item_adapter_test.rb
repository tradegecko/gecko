require 'test_helper'

class Gecko::Record::FulfillmentLineItemAdapterTest < Minitest::Test
  include TestingAdapter

  let(:adapter)       { @client.FulfillmentLineItem }
  let(:plural_name)   { 'fulfillment_line_items' }
  let(:record_class)  { Gecko::Record::FulfillmentLineItem }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::FulfillmentLineItemAdapter, @client.FulfillmentLineItem)
  end

  def test_adapter_uses_identity_map
    VCR.use_cassette('fulfillments') do
      @client.Fulfillment.where(limit: 5)
      collection = adapter.peek_all
      assert_equal(collection.first, adapter.find(collection.first.id))
    end
  end
end
