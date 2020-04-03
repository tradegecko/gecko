# frozen_string_literal: true

require 'test_helper'

class Gecko::ImageTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "images" }
  let(:record_class)  { Gecko::Record::Image }

  def setup
    @json   = load_vcr_hash("images", "images").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Image, @record)
  end

  def test_url
    @record = record_class.new(client, base_path: "https://example.com", file_name: "Gecko.jpg")
    assert_equal("https://example.com/Gecko.jpg", @record.url)
    assert_equal("https://example.com/Gecko.jpg", @record.url(:full))
    assert_equal("https://example.com/thumbnail_Gecko.jpg", @record.url(:thumbnail))
  end

  def test_building_record # rubocop:disable Metrics/MethodLength
    record = @client.adapter_for(record_class.demodulized_name).build({
      variant_ids: 1,
      product_id:  1,
      url:         "https://example.com/Gecko.jpg"
    })
    assert_equal(record.product_id, 1)
    assert_equal(record.variant_ids, [1])
    assert_equal(record.serializable_hash, {
      product_id:  1,
      variant_ids: [1],
      name:        nil,
      url:         "https://example.com/Gecko.jpg"
    })
  end
end
