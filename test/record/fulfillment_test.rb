require 'test_helper'

class Gecko::FulfillmentTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "fulfillments" }
  let(:record_class)  { Gecko::Record::Fulfillment }

  def setup
    @json   = load_vcr_hash("fulfillments", "fulfillments").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Fulfillment, @record)
  end
end
