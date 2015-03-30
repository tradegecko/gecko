module SharedSideloadedDataParsingExamples
  def test_adapter_sideloaded_data_parsing
    VCR.use_cassette(plural_name + '_sideloaded') do

      collection = adapter.where(limit: 5, _include: children.join(","))

      children.each do |child|
        child_adapter = @client.adapter_for(child.singularize.classify)

        identity_map = child_adapter.instance_variable_get(:@identity_map)
        child_collection = collection.flat_map { |record| record.send(child) }

        assert_equal child_collection, identity_map.values
      end
    end
  end
end
