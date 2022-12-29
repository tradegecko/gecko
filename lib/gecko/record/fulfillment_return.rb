require 'gecko/record/base'

module Gecko
  module Record
    class FulfillmentReturn < Base
      belongs_to :order,    writeable_on: :create
      belongs_to :company,  readonly: true
      belongs_to :location

      has_many :fulfillment_return_line_items, embedded: true

      attribute :notes,               String
      attribute :status,              String
      attribute :tracking_url,        String
      attribute :delivery_type,       String
      attribute :exchange_rate,       String
      attribute :tracking_number,     String
      attribute :tracking_company,    String
      attribute :credit_note_number,  String

      attribute :received_at,         DateTime
    end

    class FulfillmentReturnAdapter < BaseAdapter
    end
  end
end
