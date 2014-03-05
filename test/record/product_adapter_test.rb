require 'test_helper'

class Gecko::Record::ProductAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.Product }
  let(:plural_name)   { "products" }
  let(:record_class)  { Gecko::Record::Product }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::ProductAdapter, @client.Product)
  end
end
