# frozen_string_literal: true

require 'test_helper'

class Gecko::OrderLineItemTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'order_line_items' }
  let(:record_class)  { Gecko::Record::OrderLineItem }

  def setup
    @json   = load_vcr_hash('order_line_items', 'order_line_items').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::OrderLineItem, @record)
  end

  def test_discounted_price_with_discount
    record = record_class.new(client, price: 20, discount: 20)
    assert_equal(16, record.discounted_price)
  end

  def test_discounted_price_with_discount_amount
    record = record_class.new(client, price: 20, discount_amount: 5)
    assert_equal(15, record.discounted_price)
  end
end
