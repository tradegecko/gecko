require 'gecko/record/base'

module Gecko
  module Record
    class Order < Base
      has_many :fulfillments
      has_many :invoices
      has_many :order_line_items

      belongs_to :company
      belongs_to :contact
      belongs_to :shipping_address,     class_name: 'Address'
      belongs_to :billing_address,      class_name: 'Address'
      belongs_to :user,                 readonly: true
      belongs_to :assignee,             class_name: 'User'
      belongs_to :stock_location,       class_name: 'Location'
      belongs_to :currency
      # belongs_to :default_price_list,   class_name: 'PriceList'
      attribute :default_price_list_id, String

      attribute :order_number,          String
      attribute :phone_number,          String
      attribute :email,                 String
      attribute :notes,                 String
      attribute :reference_number,      String
      attribute :status,                String
      attribute :packed_status,         String,     readonly: true
      attribute :fulfillment_status,    String,     readonly: true
      attribute :invoice_status,        String,     readonly: true
      attribute :payment_status,        String,     readonly: true
      attribute :return_status,         String,     readonly: true
      attribute :returning_status,      String,     readonly: true
      attribute :shippability_status,   String,     readonly: true
      attribute :backordering_status,   String,     readonly: true
      attribute :tax_treatment,         String
      attribute :issued_at,             Date
      attribute :ship_at,               Date
      attribute :tags,                  Array[String]
      attribute :tax_override,          BigDecimal, readonly: true
      attribute :tax_label,             String,     readonly: true
      attribute :source_url,            String
      attribute :document_url,          String,     readonly: true
      attribute :total,                 BigDecimal, readonly: true

      attribute :source_id,             String,     readonly: true

      ## DEPRECATED
      attribute :tracking_number,       String,     readonly: true

      # attribute :source,                String

      # attribute :invoice_numbers,       Hash[Integer => String], readonly: true
    end

    class OrderAdapter < BaseAdapter
    end
  end
end
