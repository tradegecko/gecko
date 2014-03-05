require 'test_helper'

class Gecko::Record::VariantAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.Variant }
  let(:plural_name)   { "variants" }
  let(:record_class)  { Gecko::Record::Variant }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::VariantAdapter, @client.Variant)
  end
end
