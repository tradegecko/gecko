require 'test_helper'

class Gecko::NoteTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'notes' }
  let(:record_class)  { Gecko::Record::Note }

  def setup
    @json   = load_vcr_hash('notes', 'notes').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Note, @record)
  end
end
