require 'test_helper'

class Gecko::ProductTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "products" }
  let(:record_class)  { Gecko::Record::Product }

  def setup
    @json   = load_vcr_hash("products", "products").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Product, @record)
  end
end
