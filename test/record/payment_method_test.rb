require 'test_helper'

class Gecko::PaymentMethodTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "payment_methods" }
  let(:record_class)  { Gecko::Record::PaymentMethod }

  def setup
    @json   = load_vcr_hash("payment_methods", "payment_methods").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::PaymentMethod, @record)
  end
end
