# frozen_string_literal: true

require 'test_helper'

class Gecko::Record::StockAdjustmentLineItemAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.StockAdjustmentLineItem }
  let(:plural_name)   { 'stock_adjustment_line_items' }
  let(:record_class)  { Gecko::Record::StockAdjustmentLineItem }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::StockAdjustmentLineItemAdapter, @client.StockAdjustmentLineItem)
  end
end
