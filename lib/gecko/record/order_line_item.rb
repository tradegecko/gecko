# frozen_string_literal: true

require 'gecko/record/base'

module Gecko
  module Record
    class OrderLineItem < Base
      belongs_to :order, writeable_on: :create
      belongs_to :variant, writeable_on: :create
      belongs_to :tax_type

      has_many :fulfillment_line_items
      has_many :fulfillment_return_line_items
      has_many :invoice_line_items

      attribute :label,     String
      attribute :line_type, String

      attribute :freeform,  Boolean
      attribute :shippable, Boolean, readonly: true

      attribute :discount,  BigDecimal
      attribute :discount_amount, BigDecimal

      attribute :quantity,  BigDecimal
      attribute :price,     BigDecimal
      attribute :tax_rate_override,  BigDecimal

      attribute :position,  Integer

      attribute :image_url, String,     readonly: true

      def discounted_price
        if discount_amount&.nonzero?
          price - discount_amount
        else
          price * discount_multiplier
        end
      end

    private

      def discount_multiplier
        return 1 unless discount

        1 - discount / 100
      end
    end

    class OrderLineItemAdapter < BaseAdapter
    end
  end
end
