# frozen_string_literal: true

require 'test_helper'

class Gecko::Record::InvoiceAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.Invoice }
  let(:plural_name)   { "invoices" }
  let(:record_class)  { Gecko::Record::Invoice }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::InvoiceAdapter, @client.Invoice)
  end
end
