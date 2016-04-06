require 'test_helper'

class Gecko::PriceListTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "price_lists" }
  let(:record_class)  { Gecko::Record::PriceList }

  def setup
    @json   = load_vcr_hash("price_lists", "price_lists").first
    @record = record_class.new(client, @json)
  end

  def test_sets_up_id
    assert_instance_of(String, @record.id)
    assert_equal(@json["id"], @record.id)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::PriceList, @record)
  end
end
