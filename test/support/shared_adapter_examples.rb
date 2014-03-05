# Shared tests for Gecko::Record Adapters
# requires definition of several variables
# - adapter
# - vcr_cassette_name
# - record_class

module SharedAdapterExamples
  def test_adapter_all
    VCR.use_cassette(vcr_cassette_name) do
      collection = adapter.where(limit: 5)
      assert_instance_of(Array, collection)
      assert_equal(5, collection.size)
      assert_instance_of(record_class, collection[0])
    end
  end

  def test_adapter_count
    skip("Skipping #{adapter.class}#count") unless adapter.respond_to?(:count)
    VCR.use_cassette(vcr_cassette_name) do
      adapter.where(limit: 5)
      assert(adapter.count > 10)
    end
  end

  def test_adapter_uses_identity_map
    VCR.use_cassette(vcr_cassette_name) do
      collection = adapter.where(limit: 5)
      assert_equal(collection.first, adapter.find(collection.first.id))
    end
  end
end
