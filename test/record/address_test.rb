require 'test_helper'

class Gecko::VariantTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  def setup
    @json = load_vcr_hash("addresses", "addresses").first
    @record = Gecko::Record::Address.new(Gecko::Client.new("ABC", "DEF"), @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Address, @record)
  end
end
