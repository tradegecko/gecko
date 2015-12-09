require 'gecko/record/base'

module Gecko
  module Record
    class PurchaseOrder < Base
      has_many :purchase_order_line_items
      has_many :procurements

      belongs_to :company
      belongs_to :supplier_address,   class_name: "Address"
      belongs_to :stock_location,     class_name: "Location"
      belongs_to :billing_address,    class_name: "Location"

      belongs_to :currency
      # belongs_to :default_price_list, class_name: "PriceList"
      attribute :default_price_list_id, String

      attribute :order_number,          String
      attribute :reference_number,      String
      attribute :email,                 String
      attribute :due_at,                Date
      attribute :received_at,           Date

      attribute :status,                String
      attribute :procurement_status,    String,     readonly: true
      attribute :notes,                 String
      attribute :tax_treatment,         String

      attribute :document_url,          String,     readonly: true

      attribute :total,                 BigDecimal, readonly: true
      attribute :cached_quantity,       BigDecimal, readonly: true

      attribute :tags,                  Array[String]

      # DEPRECATED
      # attribute :cached_total,          BigDecimal, readonly: true
    end

    class PurchaseOrderAdapter < BaseAdapter

    end
  end
end
