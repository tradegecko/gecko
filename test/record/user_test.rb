require 'test_helper'

class Gecko::UserTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { 'users' }
  let(:record_class)  { Gecko::Record::User }

  def setup
    @json   = load_vcr_hash('users', 'users').first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::User, @record)
  end
end
