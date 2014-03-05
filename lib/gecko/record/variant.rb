require 'gecko/record/base'

module Gecko
  module Record
    class Variant < Base
      belongs_to :product
      has_many :images

      attribute :name,            String
      attribute :description,     String

      attribute :sku,             String
      attribute :upc,             String
      attribute :supplier_code,   String

      attribute :opt1,            String
      attribute :opt2,            String
      attribute :opt3,            String

      attribute :weight,          String

      attribute :status,          String

      attribute :product_name,    String
      attribute :product_status,  String
      attribute :product_type,    String


      attribute :wholesale_price, BigDecimal
      attribute :retail_price,    BigDecimal
      attribute :buy_price,       BigDecimal

      attribute :moving_average_cost, BigDecimal
      attribute :last_cost_price,     BigDecimal

      attribute :manage_stock,    Integer
      attribute :reorder_point,   Integer
      attribute :max_online,      Integer

      attribute :composite,       Boolean
      attribute :keep_selling,    Boolean
      attribute :taxable,         Boolean
      attribute :sellable,        Boolean
      attribute :online_ordering, Boolean

      attribute :position,        Integer

      attribute :stock_on_hand,   BigDecimal
      attribute :committed_stock, BigDecimal

      attribute :prices,                 Hash[Symbol => BigDecimal]
      attribute :stock_levels,           Hash[Integer => BigDecimal]
      attribute :committed_stock_levels, Hash[Integer => BigDecimal]

      # attribute :is_online
      # attribute :online_id


      # Returns a display name for a variant
      #
      # @example
      #   variant.display_name #=> "ABC12-Alpha Rocket"
      #
      # @return [String]
      #
      # @api public
      def display_name
        if !name.include?(product_name)
          parts = [sku, product_name, name]
        else
          parts = [sku, name]
        end
        parts.select { |part| part && part.length }.join(" - ")
      end
    end

    class VariantAdapter < BaseAdapter
    end
  end
end
