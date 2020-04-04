# frozen_string_literal: true

require 'test_helper'

class Gecko::VariantTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'variants' }
  let(:record_class)  { Gecko::Record::Variant }

  def setup
    @json   = load_vcr_hash('variants', 'variants').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Variant, @record)
  end

  def test_blank_display_name
    record = record_class.new(client, {})
    assert_equal(record.display_name, "")
  end

  def test_variant_prices
    json = { variant_prices: [{ price_list_id: "buy", value: "12.50" }, { price_list_id: 123, value: "14.00" }] }
    variant_prices = record_class.new(client, json).variant_prices
    assert_instance_of(Gecko::Record::Variant::VariantPrice, variant_prices.first)
    assert_equal(variant_prices[0].price_list_id, "buy")
    assert_equal(variant_prices[1].price_list_id, "123")
    assert_equal(variant_prices[1].value, 14.0)
  end

  def test_variant_locations
    json = { locations: [
      { location_id: 1, stock_on_hand: "12.50",
        committed: "0", bin_location: "AB-123" }
    ] }

    locations = record_class.new(client, json).locations
    assert_instance_of(Gecko::Record::Variant::VariantLocation, locations.first)
    assert_equal(1,        locations[0].location_id)
    assert_equal(12.5,     locations[0].stock_on_hand)
    assert_equal(0,        locations[0].committed_stock)
    assert_equal("AB-123", locations[0].bin_location)
  end
end
