# frozen_string_literal: true

require 'gecko/record/base'

module Gecko
  module Record
    class Webhook < Base
      EVENTS = %w[
        address.create
        address.update
        company.create
        company.update
        contact.create
        contact.update
        fulfillment.create
        fulfillment.fulfilled
        fulfillment_return.create
        image.create
        invoice.create
        location.create
        location.update
        order.create
        order.finalized
        order.fulfilled
        payment.create
        procurement.create
        product.create
        purchase_order.create
        stock_adjustment.create
        stock_transfer.create
        variant.create
      ].freeze

      attribute :address, String
      attribute :event,   String
    end

    class WebhookAdapter < BaseAdapter
    end
  end
end
