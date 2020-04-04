# frozen_string_literal: true

require 'test_helper'

class Gecko::Record::InvoiceLineItemAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.InvoiceLineItem }
  let(:plural_name)   { "invoice_line_items" }
  let(:record_class)  { Gecko::Record::InvoiceLineItem }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::InvoiceLineItemAdapter, @client.InvoiceLineItem)
  end

private

  def random_attribute
    :quantity
  end
end
