# frozen_string_literal: true

require 'test_helper'

class Gecko::StockAdjustmentTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'stock_adjustments' }
  let(:record_class)  { Gecko::Record::StockAdjustment }

  def setup
    @json   = load_vcr_hash('stock_adjustments', 'stock_adjustments').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::StockAdjustment, @record)
  end
end
