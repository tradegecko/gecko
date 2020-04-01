require 'gecko/record/base'

module Gecko
  module Record
    class Invoice < Base
      belongs_to :order, writeable_on: :create
      belongs_to :shipping_address
      belongs_to :billing_address
      belongs_to :payment_term
      belongs_to :company,                    readonly: true
      belongs_to :currency,                   readonly: true

      has_many :invoice_line_items, embedded: true

      attribute :invoice_number,  String
      attribute :order_number,    String,     readonly: true
      attribute :invoiced_at,     Date
      attribute :due_at,          Date
      attribute :notes,           String
      attribute :exchange_rate,   BigDecimal

      attribute :status,          String,     readonly: true
      attribute :payment_status,  String,     readonly: true
      attribute :total,           BigDecimal, readonly: true
      attribute :document_url,    String,     readonly: true
    end

    class InvoiceAdapter < BaseAdapter

    end
  end
end
