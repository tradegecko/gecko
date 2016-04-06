require 'test_helper'

class Gecko::PaymentTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "payments" }
  let(:record_class)  { Gecko::Record::Payment }

  def setup
    @json   = load_vcr_hash("payments", "payments").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Payment, @record)
  end
end
