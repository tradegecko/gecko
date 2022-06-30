require 'test_helper'
require 'pry'

class Gecko::CompositionTest < Minitest::Test
  include TestingAdapter
  include VCRHelper

  let(:record_class)  { Gecko::Record::Composition }

  def test_initializes_record
    composition_array = load_vcr_hash('composition', 'composition')
    record = record_class.new(@client, composition_array.first)
    assert_instance_of(Gecko::Record::Composition, record)
    assert !record.persisted?
  end

  def test_composition_sideloading
    VCR.use_cassette('composition#sideloading') do
      result = @client.Composition.where(include: "bundle,component")
      variant_adapter = @client.adapter_for("Variant")
      sideloaded_ids_set = Set.new(result.flat_map { |r| [r.bundle_id, r.component_id] })
      sideloaded_ids_set.all? do |variant_id|
        assert variant_adapter.has_record_for_id?(variant_id)
      end
    end
  end

  def test_fails_saving_record
    assert_raises ::NotImplementedError do
      composition_array = load_vcr_hash('composition', 'composition')
      record = record_class.new(@client, composition_array.first)
      @client.adapter_for("Composition").save(record)
    end
  end
end
