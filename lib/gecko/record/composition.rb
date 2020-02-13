require 'gecko/record/base'

module Gecko
  module Record
    class Composition
      include Virtus.model
      include Gecko::Helpers::AssociationHelper
      include Gecko::Helpers::InspectionHelper
      include Gecko::Helpers::SerializationHelper

      belongs_to :bundle,    class_name: "Variant", readonly: true
      belongs_to :component, class_name: "Variant", readonly: true

      attribute :bundle_sku,    String,     readonly: true
      attribute :component_sku, String,     readonly: true
      attribute :quantity,      BigDecimal, readonly: true


      def initialize(client, attributes = {})
        super(attributes)
        @client = client
      end

      # A Computed Read-Only Record. Can not be persisted.
      def persisted?
        false
      end
    end

    class CompositionAdapter < BaseAdapter
      def plural_path
        'variants/composition'
      end

      def instantiate_and_register_record(records_json)
        records_json.map { |single_composition| super(single_composition) }
      end

      def parse_records(json)
        parse_sideloaded_records(json.except(json_root))
        instantiate_and_register_record(json[json_root])
      end

      def register_record(record)
        @identity_map[record.bundle_id] = record
      end

      # Can not save a composition record.
      def save(_record, _opts = {})
        raise NotImplementedError
      end
    end
  end
end
