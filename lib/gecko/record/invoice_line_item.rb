require 'gecko/record/base'

module Gecko
  module Record
    class InvoiceLineItem < Base
      belongs_to :invoice
      belongs_to :order_line_item

      attribute :quantity,   BigDecimal
      attribute :base_price, BigDecimal, readonly: true

      attribute :position,   Integer
    end

    class InvoiceLineItemAdapter < BaseAdapter
      # Returns all cached records for testing
      #
      # @return [Array<Gecko::Record::InvoiceLineItem>]
      #
      # @api private
      def all
        @identity_map.values
      end
    end
  end
end
