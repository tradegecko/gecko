# frozen_string_literal: true

require 'test_helper'

class Gecko::LocationTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'locations' }
  let(:record_class)  { Gecko::Record::Location }

  def setup
    @json   = load_vcr_hash('locations', 'locations').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Location, @record)
  end
end
