require 'gecko/record/base'

module Gecko
  module Record
    class Variant < Base
      class VariantLocation
        include Virtus.model
        include Gecko::Helpers::SerializationHelper
        attribute :location_id,     Integer
        attribute :committed,       BigDecimal
        attribute :stock_on_hand,   BigDecimal
        attribute :bin_location,    String

        alias_method :committed_stock, :committed
      end

      class VariantPrice
        include Virtus.model
        include Gecko::Helpers::SerializationHelper
        attribute :price_list_id,    String
        attribute :value,            BigDecimal
      end

      belongs_to :product, writeable_on: :create
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
      attribute :weight_unit,     String

      attribute :status,          String,   readonly: true

      attribute :product_name,    String,   readonly: true
      attribute :product_status,  String,   readonly: true
      attribute :product_type,    String,   readonly: true

      attribute :wholesale_price, BigDecimal
      attribute :retail_price,    BigDecimal
      attribute :buy_price,       BigDecimal

      attribute :moving_average_cost, BigDecimal, readonly: true
      attribute :last_cost_price,     BigDecimal, readonly: true

      attribute :manage_stock,    Integer
      attribute :reorder_point,   Integer
      attribute :max_online,      Integer

      attribute :keep_selling,    Boolean
      attribute :taxable,         Boolean
      attribute :sellable,        Boolean
      attribute :online_ordering, Boolean

      attribute :position,        Integer

      attribute :stock_on_hand,   BigDecimal, readonly: true
      attribute :incoming_stock,  BigDecimal, readonly: true
      attribute :committed_stock, BigDecimal, readonly: true

      attribute :locations,       Array[VariantLocation]
      attribute :variant_prices,  Array[VariantPrice]

      attribute :composite,           Boolean,    writeable_on: :create
      attribute :initial_stock_level, BigDecimal, writeable_on: :create
      attribute :initial_cost_price,  BigDecimal, writeable_on: :create

      # Returns a display name for a variant
      #
      # @example
      #   variant.display_name #=> "ABC12-Alpha Rocket"
      #
      # @return [String]
      #
      # @api public
      def display_name
        if name.nil? || !name.include?(product_name)
          parts = [sku, product_name, name]
        else
          parts = [sku, name]
        end
        parts.select { |part| part && part.length }.join(' - ')
      end

      # attribute :is_online

      ## DEPRECATED
      # attribute :prices,                 Hash[String => BigDecimal],  readonly: true
      # attribute :stock_levels,           Hash[Integer => BigDecimal], readonly: true
      # attribute :committed_stock_levels, Hash[Integer => BigDecimal], readonly: true
      # attribute :online_id
    end

    class VariantAdapter < BaseAdapter
    end
  end
end
