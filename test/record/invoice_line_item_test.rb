require 'test_helper'

class Gecko::InvoiceLineItemTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "invoice_line_items" }
  let(:record_class)  { Gecko::Record::InvoiceLineItem }

  def setup
    @json   = load_vcr_hash("invoice_line_items", "invoice_line_items").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::InvoiceLineItem, @record)
  end
end
