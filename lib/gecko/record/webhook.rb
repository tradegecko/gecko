require 'gecko/record/base'

module Gecko
  module Record
    class Webhook < Base
      attribute :address, String
      attribute :event,   String
    end

    class WebhookAdapter < BaseAdapter
    end
  end
end
