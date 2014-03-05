require 'test_helper'

class Gecko::FulfillmentTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  def setup
    @json = load_vcr_hash("fulfillments", "fulfillments").first
    @record = Gecko::Record::Fulfillment.new(Gecko::Client.new("ABC", "DEF"), @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Fulfillment, @record)
  end
end
