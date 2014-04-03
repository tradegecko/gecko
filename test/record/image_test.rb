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
end
