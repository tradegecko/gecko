require 'test_helper'
class Gecko::Record::AccountAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples
  undef :test_adapter_count
  undef :test_adapter_size

  # Can't build accounts via API
  undef :test_build
  undef :test_build_with_attributes
  undef :test_saving_new_record
  undef :test_saving_new_invalid_record
  undef :test_saving_record_with_idempotency_key

  let(:adapter)       { @client.Account }
  let(:plural_name)   { 'accounts' }
  let(:record_class)  { Gecko::Record::Account }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::AccountAdapter, @client.Account)
  end

  def test_current
    VCR.use_cassette('accounts#current') do
      assert_instance_of(Gecko::Record::Account, @client.Account.current)
      assert(@client.Account.current, 'Account.current is identity mapped')
    end
  end

  def test_adapter_all
    VCR.use_cassette(plural_name) do
      collection = adapter.where(limit: 5)
      assert_instance_of(Array, collection)
      assert_equal(1, collection.size)
      assert_instance_of(record_class, collection[0])
    end
  end

  def test_adapter_uses_identity_map
    VCR.use_cassette(plural_name) do
      collection = adapter.where(limit: 5)
      assert_equal(collection.first, adapter.find(collection.first.id))
    end
  end
end
