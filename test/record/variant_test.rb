require 'test_helper'

class Gecko::VariantTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'variants' }
  let(:record_class)  { Gecko::Record::Variant }

  def setup
    @json   = load_vcr_hash('variants', 'variants').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Variant, @record)
  end
end
