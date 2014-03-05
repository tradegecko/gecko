require 'test_helper'

class Gecko::ProductTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  def setup
    @json = load_vcr_hash("products", "products").first
    @record = Gecko::Record::Product.new(Gecko::Client.new("ABC", "DEF"), @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Product, @record)
  end
end
