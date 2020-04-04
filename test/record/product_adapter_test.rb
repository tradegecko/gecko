# frozen_string_literal: true

require 'test_helper'

class Gecko::Record::ProductAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples
  include SharedSideloadedDataParsingExamples

  let(:adapter)       { @client.Product }
  let(:plural_name)   { 'products' }
  let(:record_class)  { Gecko::Record::Product }
  let(:children)      { ["variants"] }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::ProductAdapter, @client.Product)
  end

  def test_saves_new_record
    VCR.use_cassette(plural_name + '_new_valid') do
      record = adapter.build(name: 'Gary')
      assert record.save
      assert record.id
      assert adapter.has_record_for_id?(record.id)
    end
  end

  def test_invalid_new_record
    VCR.use_cassette(plural_name + '_new_invalid') do
      record = adapter.build(product_type: 'Gecko')
      assert !record.save
      assert !record.id
      assert_equal record.errors[:name], ["can't be blank"]
    end
  end
end
