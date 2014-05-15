require 'gecko/record/base'

module Gecko
  module Record
    class FulfillmentLineItem < Base
      belongs_to :fulfillment
      belongs_to :order_line_item

      attribute :quantity,   BigDecimal
      attribute :base_price, BigDecimal, readonly: true

      attribute :position,   Integer
    end

    class FulfillmentLineItemAdapter < BaseAdapter
      # Returns all cached records for testing
      #
      # @return [Array<Gecko::Record::FulfillmentLineItem>]
      #
      # @api private
      def all
        @identity_map.values
      end
    end
  end
end
