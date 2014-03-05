require 'test_helper'

class Gecko::Record::CompanyAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.Company }
  let(:plural_name)   { "companies" }
  let(:record_class)  { Gecko::Record::Company }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::CompanyAdapter, @client.Company)
  end
end
