require 'gecko/record/base'

module Gecko
  module Record
    class Payment < Base
      belongs_to :invoice, writeable_on: :create
      belongs_to :payment_method
      attribute :amount,           BigDecimal
      attribute :reference_number, String
      attribute :paid_at,          DateTime
      attribute :exchange_rate,    BigDecimal
    end

    class PaymentAdapter < BaseAdapter

    end
  end
end
