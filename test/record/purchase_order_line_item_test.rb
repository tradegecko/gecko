# frozen_string_literal: true

require 'test_helper'

class Gecko::PurchaseOrderLineItemTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "purchase_order_line_items" }
  let(:record_class)  { Gecko::Record::PurchaseOrderLineItem }

  def setup
    @json   = load_vcr_hash("purchase_order_line_items", "purchase_order_line_items").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::PurchaseOrderLineItem, @record)
  end
end
