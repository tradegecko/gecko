require 'test_helper'

class Gecko::Record::EmailTemplateAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.EmailTemplate }
  let(:plural_name)   { "email_templates" }
  let(:record_class)  { Gecko::Record::EmailTemplate }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::EmailTemplateAdapter, @client.EmailTemplate)
  end
end