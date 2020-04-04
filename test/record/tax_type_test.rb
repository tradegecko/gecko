# frozen_string_literal: true

require 'test_helper'

class Gecko::TaxTypeTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "tax_types" }
  let(:record_class)  { Gecko::Record::TaxType }

  def setup
    @json   = load_vcr_hash("tax_types", "tax_types").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::TaxType, @record)
  end
end
