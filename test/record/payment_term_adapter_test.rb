require 'test_helper'

class Gecko::Record::PaymentTermAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.PaymentTerm }
  let(:plural_name)   { "payment_terms" }
  let(:record_class)  { Gecko::Record::PaymentTerm }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::PaymentTermAdapter, @client.PaymentTerm)
  end
end
