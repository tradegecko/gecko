require 'test_helper'

class Gecko::FulfillmentReturnTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'fulfillment_returns' }
  let(:record_class)  { Gecko::Record::FulfillmentReturn }

  def setup
    @json   = load_vcr_hash('fulfillment_returns', 'fulfillment_returns').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::FulfillmentReturn, @record)
  end
end
