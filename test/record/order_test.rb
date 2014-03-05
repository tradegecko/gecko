require 'test_helper'

class Gecko::OrderTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  def setup
    @json = load_vcr_hash("orders", "orders").first
    @record = Gecko::Record::Order.new(Gecko::Client.new("ABC", "DEF"), @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Order, @record)
  end
end
