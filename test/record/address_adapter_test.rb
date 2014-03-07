require 'test_helper'

class Gecko::Record::AddressAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.Address }
  let(:plural_name)   { "addresses" }
  let(:record_class)  { Gecko::Record::Address }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::AddressAdapter, @client.Address)
  end

  def test_adapter_count
    assert !adapter.respond_to?(:count)
  end
end
