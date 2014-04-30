require 'test_helper'

class Gecko::Record::PriceListAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.PriceList }
  let(:plural_name)   { 'price_lists' }
  let(:record_class)  { Gecko::Record::PriceList }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::PriceListAdapter, @client.PriceList)
  end

  def test_register_record_symbol
    record = mock(id: :buy)
    adapter.register_record(record)
    assert_equal(record, adapter.record_for_id(:buy))
    assert_equal(record, adapter.record_for_id("buy"))
  end

  def test_register_record_string
    record = mock(id: "buy")
    adapter.register_record(record)
    assert_equal(record, adapter.record_for_id(:buy))
    assert_equal(record, adapter.record_for_id("buy"))
  end

  def test_register_bad_string
    record = mock(id: :gecko)
    adapter.register_record(record)
    assert_equal(record, adapter.record_for_id(:gecko))
  end

  def random_attribute
    :name
  end
end
