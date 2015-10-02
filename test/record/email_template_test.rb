require 'test_helper'

class Gecko::EmailTemplateTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "email_templates" }
  let(:record_class)  { Gecko::Record::EmailTemplate }

  def setup
    @json   = load_vcr_hash("email_templates", "email_templates").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::EmailTemplate, @record)
  end
end