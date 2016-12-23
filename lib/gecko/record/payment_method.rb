require 'gecko/record/base'

module Gecko
  module Record
    class PaymentMethod < Base
      attribute :name,              String
    end

    class PaymentMethodAdapter < BaseAdapter
    end
  end
end
