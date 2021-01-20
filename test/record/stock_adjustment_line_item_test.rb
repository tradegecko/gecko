# frozen_string_literal: true

require 'test_helper'

class Gecko::StockAdjustmentLineItemTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'stock_adjustment_line_items' }
  let(:record_class)  { Gecko::Record::StockAdjustmentLineItem }

  def setup
    @json   = load_vcr_hash('stock_adjustment_line_items', 'stock_adjustment_line_items').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::StockAdjustmentLineItem, @record)
  end
end
