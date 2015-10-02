require 'test_helper'

class Gecko::Record::ChannelAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.Channel }
  let(:plural_name)   { "channels" }
  let(:record_class)  { Gecko::Record::Channel }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::ChannelAdapter, @client.Channel)
  end
end