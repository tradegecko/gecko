# frozen_string_literal: true

require 'test_helper'

class Gecko::PaymentTermTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "payment_terms" }
  let(:record_class)  { Gecko::Record::PaymentTerm }

  def setup
    @json   = load_vcr_hash("payment_terms", "payment_terms").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::PaymentTerm, @record)
  end
end
