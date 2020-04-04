# frozen_string_literal: true

require 'test_helper'

class Gecko::InvoiceTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "invoices" }
  let(:record_class)  { Gecko::Record::Invoice }

  def setup
    @json   = load_vcr_hash("invoices", "invoices").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Invoice, @record)
  end
end
