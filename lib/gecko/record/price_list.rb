require 'gecko/record/base'

module Gecko
  module Record
    class PriceList < Base
      belongs_to :currency

      attribute :id,              String
      attribute :code,            String
      attribute :name,            String
      attribute :is_cost,         Boolean
      attribute :is_default,      Boolean
      attribute :position,        Integer
      attribute :currency_symbol, String
      attribute :currency_iso,    String
    end

    class PriceListAdapter < BaseAdapter
      DEFAULTS = %w|buy wholesale retail|

      undef :count

      def register_record(record)
        id = parse_id(record.id)
        @identity_map[id] = record
      end

      def record_for_id(id)
        verify_id_presence!(id)
        id = parse_id(id)
        @identity_map.fetch(id) { record_not_in_identity_map!(id) }
      end

      def has_record_for_id?(id)
        id = parse_id(id)
        @identity_map.key?(id)
      end

      def parse_id(id)
        if DEFAULTS.include?(id.to_s)
          id.to_sym
        else
          id.to_i
        end
      end
    end
  end
end
