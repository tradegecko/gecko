require 'test_helper'

class Gecko::AddressTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'addresses' }
  let(:record_class)  { Gecko::Record::Address }

  def setup
    @json   = load_vcr_hash('addresses', 'addresses').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Address, @record)
  end
end
