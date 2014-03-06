require 'test_helper'

class Gecko::OrderTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "orders" }
  let(:record_class)  { Gecko::Record::Order }

  def setup
    @json   = load_vcr_hash("orders", "orders").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Order, @record)
  end
end
