require 'gecko/record/base'

module Gecko
  module Record
    class Currency < Base
      attribute :iso,       String
      attribute :name,      String
      attribute :rate,      BigDecimal
      attribute :symbol,    String
      attribute :separator, String
      attribute :delimiter, String
      attribute :precision, Integer
      attribute :format,    String
    end

    class CurrencyAdapter < BaseAdapter
      # Override plural_path to properly pluralize currency
      def plural_path
        'currencies'
      end
    end
  end
end
