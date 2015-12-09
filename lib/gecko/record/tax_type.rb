require 'gecko/record/base'

module Gecko
  module Record
    class TaxType < Base
      attribute :name,              String
      attribute :code,              String
      attribute :effective_rate,    BigDecimal, readonly: true

      attribute :status,            String,     readonly: true

      has_many :tax_components
    end

    class TaxTypeAdapter < BaseAdapter

    end
  end
end
