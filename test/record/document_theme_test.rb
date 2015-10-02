require 'test_helper'

class Gecko::DocumentThemeTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "document_themes" }
  let(:record_class)  { Gecko::Record::DocumentTheme }

  def setup
    @json   = load_vcr_hash("document_themes", "document_themes").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::DocumentTheme, @record)
  end
end