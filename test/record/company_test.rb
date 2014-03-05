require 'test_helper'

class Gecko::CompanyTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  def setup
    @json = load_vcr_hash("companies", "companies").first
    @record = Gecko::Record::Company.new(Gecko::Client.new("ABC", "DEF"), @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Company, @record)
  end
end
