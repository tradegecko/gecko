require 'gecko/record/base'

module Gecko
  module Record
    class PurchaseOrderLineItem < Base
      belongs_to :purchase_order
      belongs_to :variant
      belongs_to :procurement
      belongs_to :tax_type

      attribute :quantity,          BigDecimal
      attribute :position,          Integer
      attribute :tax_rate_override, BigDecimal
      attribute :price,             BigDecimal
      attribute :label,             String
      attribute :freeform,          Boolean

      attribute :base_price,        BigDecimal, readonly: true
      attribute :extra_cost_value,  BigDecimal, readonly: true
      attribute :image_url,         String,     readonly: true
      # DEPRECATED
      # attribute :tax_rate, String
    end

    class PurchaseOrderLineItemAdapter < BaseAdapter

    end
  end
end
