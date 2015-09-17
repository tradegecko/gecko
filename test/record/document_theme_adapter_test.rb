require 'test_helper'

class Gecko::Record::DocumentThemeAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.DocumentTheme }
  let(:plural_name)   { "document_themes" }
  let(:record_class)  { Gecko::Record::DocumentTheme }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::DocumentThemeAdapter, @client.DocumentTheme)
  end
end