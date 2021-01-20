# frozen_string_literal: true

require 'test_helper'

class Gecko::Record::StockAdjustmentAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.StockAdjustment }
  let(:plural_name)   { 'stock_adjustments' }
  let(:record_class)  { Gecko::Record::StockAdjustment }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::StockAdjustmentAdapter, @client.StockAdjustment)
  end
end
