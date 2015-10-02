require 'gecko/record/base'

module Gecko
  module Record
    class DocumentTheme < Base
      attribute :name,                       String
      attribute :invoice_details,            String
      attribute :quote_details,              String
      attribute :sales_order_details,        String
      attribute :invoice_title,              String
      attribute :packing_slip_title,         String
      attribute :pick_list_title,            String
      attribute :pick_list_expand_composite, String
      attribute :credit_note_title,          String
      attribute :purchase_order_title,       String
      attribute :quote_title,                String
      attribute :sales_order_title,          String
      attribute :shipping_details_title,     String
      attribute :shipping_label_title,       String
      attribute :stock_transfer_title,       String
      attribute :footer,                     String
      attribute :font_colour,                String
      attribute :base_colour,                String
      attribute :email_logo_url,             String
      attribute :pdf_logo_url,               String
      attribute :subdomain,                  String
    end

    class DocumentThemeAdapter < BaseAdapter
    end
  end
end
