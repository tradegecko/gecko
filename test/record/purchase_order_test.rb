require 'test_helper'

class Gecko::PurchaseOrderTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "purchase_orders" }
  let(:record_class)  { Gecko::Record::PurchaseOrder }

  def setup
    @json   = load_vcr_hash("purchase_orders", "purchase_orders").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::PurchaseOrder, @record)
  end
end
