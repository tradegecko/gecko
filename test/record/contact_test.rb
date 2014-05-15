require 'test_helper'

class Gecko::ContactTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "contacts" }
  let(:record_class)  { Gecko::Record::Contact }

  def setup
    @json   = load_vcr_hash("contacts", "contacts").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Contact, @record)
  end
end