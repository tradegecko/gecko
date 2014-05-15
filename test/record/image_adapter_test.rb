require 'test_helper'

class Gecko::Record::ImageAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.Image }
  let(:plural_name)   { "images" }
  let(:record_class)  { Gecko::Record::Image }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::ImageAdapter, @client.Image)
  end
end
