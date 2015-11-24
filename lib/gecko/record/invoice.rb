require 'gecko/record/base'

module Gecko
  module Record
    class Invoice < Base
      belongs_to :order
      belongs_to :shipping_address
      belongs_to :billing_address
      belongs_to :payment_term

      has_many :invoice_line_items

      attribute :invoice_number,  String
      attribute :invoiced_at,     Date
      attribute :due_at,          Date
      attribute :notes,           String
      attribute :exchange_rate,   BigDecimal

      attribute :destination_url, String,   readonly: true
      attribute :document_url,    String,   readonly: true
    end

    class InvoiceAdapter < BaseAdapter

    end
  end
end
