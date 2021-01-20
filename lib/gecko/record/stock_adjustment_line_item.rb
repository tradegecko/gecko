# frozen_string_literal: true

require 'gecko/record/base'

module Gecko
  module Record
    class StockAdjustmentLineItem < Base
      belongs_to :stock_adjustment, writeable_on: :create
      belongs_to :variant, writeable_on: :create

      attribute :quantity,  BigDecimal
      attribute :price,     BigDecimal

      attribute :position,  Integer
    end

    class StockAdjustmentLineItemAdapter < BaseAdapter
    end
  end
end
