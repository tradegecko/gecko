# frozen_string_literal: true

require 'test_helper'

class Gecko::Record::ContactAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.Contact }
  let(:plural_name)   { "contacts" }
  let(:record_class)  { Gecko::Record::Contact }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::ContactAdapter, @client.Contact)
  end
end
