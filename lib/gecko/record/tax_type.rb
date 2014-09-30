require 'gecko/record/base'

module Gecko
  module Record
    class TaxType < Base
      attribute :name,              String
      attribute :code,              String
      attribute :xero_online_id,    String
      attribute :imported_from,     String
      attribute :effective_rate,    BigDecimal

      attribute :status,            String

      # has_many :tax_components
    end

    class TaxTypeAdapter < BaseAdapter

    end
  end
end
