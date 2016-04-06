require 'test_helper'

class Gecko::Record::PaymentAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.Payment }
  let(:plural_name)   { "payments" }
  let(:record_class)  { Gecko::Record::Payment }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::PaymentAdapter, @client.Payment)
  end
end
