require 'gecko/record/base'
require 'gecko/record/invoice_line_item'

module Gecko
  module Record
    class Invoice < Base
      belongs_to :order
      belongs_to :shipping_address, class_name: 'Address'
      belongs_to :billing_address,  class_name: 'Address'
      has_many :invoice_line_items

      attribute :invoice_number,   String
      attribute :notes,            String
      attribute :exchange_rate,    String
      attribute :destination_url,  String,  readonly: true

      attribute :invoiced_at,      DateTime
      attribute :due_at,           Date
    end

    class InvoiceAdapter < BaseAdapter
      # Parse sideloaded InvoiceLineItems into the Identity map
      # instead of refetching them
      def parse_records(json)
        records = super
        parse_line_items(json) if json['invoice_line_items']
        records
      end

      def parse_line_items(json)
        @client.InvoiceLineItem.parse_records(json)
      end
    end
  end
end
