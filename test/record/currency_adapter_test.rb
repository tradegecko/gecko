require 'test_helper'

class Gecko::Record::CurrencyAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.Currency }
  let(:plural_name)   { "currencies" }
  let(:record_class)  { Gecko::Record::Currency }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::CurrencyAdapter, @client.Currency)
  end

  undef :test_adapter_count
end
