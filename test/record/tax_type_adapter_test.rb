require 'test_helper'

class Gecko::Record::TaxTypeAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.TaxType }
  let(:plural_name)   { "tax_types" }
  let(:record_class)  { Gecko::Record::TaxType }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::TaxTypeAdapter, @client.TaxType)
  end
end
