require 'gecko/record/base'

module Gecko
  module Record
    class PaymentTerm < Base
      attribute :name,              String
      attribute :status,            String, readonly: true
      attribute :due_in_days,       Integer
      attribute :from,              String
    end

    class PaymentTermAdapter < BaseAdapter

    end
  end
end
