require 'gecko/record/base'

module Gecko
  module Record
    class FulfillmentReturnLineItem < Base
      belongs_to :fulfillment_return, writeable_on: :create
      belongs_to :order_line_item, writeable_on: :create

      attribute :quantity,   BigDecimal
      attribute :base_price, BigDecimal, readonly: true

      attribute :position,   Integer
    end

    class FulfillmentReturnLineItemAdapter < BaseAdapter
    end
  end
end
