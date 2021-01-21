# frozen_string_literal: true

require 'gecko/record/base'
require 'gecko/record/stock_adjustment_line_item'

module Gecko
  module Record
    class StockAdjustment < Base
      belongs_to :stock_location,  class_name: 'Location'

      has_many :stock_adjustment_line_items, embedded: true

      attribute :adjustment_number,           String
      attribute :notes,                       String
      attribute :reason,                    	String
      attribute :reason_label,              	String
      attribute :stock_adjustment_reason_id,	Integer
      attribute :stock_location_id,       	  Integer
      attribute :cached_quantity,         	  String, readonly: true
      attribute :cached_total,            	  String, readonly: true
    end

    class StockAdjustmentAdapter < BaseAdapter
    end
  end
end
