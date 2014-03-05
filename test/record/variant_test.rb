require 'test_helper'

class Gecko::VariantTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  def setup
    @json = load_vcr_hash("variants", "variants").first
    @record = Gecko::Record::Variant.new(Gecko::Client.new("ABC", "DEF"), @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Variant, @record)
  end
end
