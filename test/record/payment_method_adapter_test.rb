require 'test_helper'

class Gecko::Record::PaymentMethodAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.PaymentMethod }
  let(:plural_name)   { "payment_methods" }
  let(:record_class)  { Gecko::Record::PaymentMethod }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::PaymentMethodAdapter, @client.PaymentMethod)
  end
end
