require 'test_helper'

class Gecko::CompanyTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'companies' }
  let(:record_class)  { Gecko::Record::Company }

  def setup
    @json   = load_vcr_hash('companies', 'companies').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Company, @record)
  end
end
