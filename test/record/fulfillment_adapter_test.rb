require 'test_helper'

class Gecko::Record::FulfillmentAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.Fulfillment }
  let(:plural_name)   { "fulfillments" }
  let(:record_class)  { Gecko::Record::Fulfillment }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::FulfillmentAdapter, @client.Fulfillment)
  end

  def test_identity_map_stores_sideloaded_line_items
    VCR.use_cassette("fulfillments") do
      collection = @client.Fulfillment.where(limit: 5)
      fulfillment = collection.first
      item = fulfillment.fulfillment_line_items.first
      assert_instance_of(Gecko::Record::FulfillmentLineItem, item)
      assert_equal(fulfillment, item.fulfillment)
    end
  end
end
