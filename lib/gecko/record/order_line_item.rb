require 'gecko/record/base'

module Gecko
  module Record
    class OrderLineItem < Base
      belongs_to :order
      belongs_to :variant
      has_many :fulfillment_line_items
      has_many :invoice_line_items

      attribute :label,     String
      attribute :freeform,  Boolean

      attribute :discount,  BigDecimal
      attribute :quantity,  BigDecimal
      attribute :price,     BigDecimal
      attribute :tax_rate,  BigDecimal

      attribute :position,  Integer

      attribute :image_url, String
    end

    class OrderLineItemAdapter < BaseAdapter
      undef :count
    end
  end
end
