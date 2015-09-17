require 'test_helper'

class Gecko::ChannelTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "channels" }
  let(:record_class)  { Gecko::Record::Channel }

  def setup
    @json   = load_vcr_hash("channels", "channels").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Channel, @record)
  end
end