require 'test_helper'

class Gecko::CurrencyTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'currencies' }
  let(:record_class)  { Gecko::Record::Currency }

  def setup
    @json   = load_vcr_hash('currencies', 'currencies').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Currency, @record)
  end
end
