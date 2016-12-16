require 'gecko/record/base'

module Gecko
  module Record
    class PaymentMethod < Base
      attribute :name,       String
      attribute :is_default, Boolean, readonly: true
    end

    class PaymentMethodAdapter < BaseAdapter

    end
  end
end
