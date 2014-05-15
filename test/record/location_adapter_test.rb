require 'test_helper'

class Gecko::Record::LocationAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.Location }
  let(:plural_name)   { 'locations' }
  let(:record_class)  { Gecko::Record::Location }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::LocationAdapter, @client.Location)
  end
end
