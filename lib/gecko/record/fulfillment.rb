require 'gecko/record/base'
require 'gecko/record/fulfillment_line_item'

module Gecko
  module Record
    class Fulfillment < Base
      belongs_to :order, writeable_on: :create
      belongs_to :shipping_address, class_name: 'Address'
      belongs_to :billing_address,  class_name: 'Address'
      belongs_to :stock_location,  class_name: 'Location'

      has_many :fulfillment_line_items

      attribute :status,           String
      attribute :exchange_rate,    String
      attribute :delivery_type,    String
      attribute :tracking_number,  String
      attribute :notes,            String
      attribute :tracking_url,     String
      attribute :tracking_company, String

      attribute :packed_at,        Date
      attribute :shipped_at,       DateTime
      attribute :received_at,      DateTime
      attribute :service,          String

      attribute :receipt,          Hash
    end

    class FulfillmentAdapter < BaseAdapter
    end
  end
end
