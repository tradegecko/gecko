require 'test_helper'
class Gecko::Record::AccountAdapterTest < Minitest::Test
  include TestingAdapter

  let(:adapter)           { @client.Account }
  let(:vcr_cassette_name) { "accounts" }
  let(:record_class)      { Gecko::Record::Account }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::AccountAdapter, @client.Account)
  end

  def test_current
    VCR.use_cassette("accounts#current") do
      assert_instance_of(Gecko::Record::Account, @client.Account.current)
      assert(@client.Account.current, "Account.current is identity mapped")
    end
  end

  def test_adapter_uses_identity_map
    VCR.use_cassette(vcr_cassette_name) do
      collection = adapter.where(limit: 5)
      assert_equal(collection.first, adapter.find(collection.first.id))
    end
  end
end
