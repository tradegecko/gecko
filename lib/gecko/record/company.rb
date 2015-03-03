require 'gecko/record/base'

module Gecko
  module Record
    class Company < Base
      belongs_to :assignee,         class_name: "User"
      belongs_to :default_tax_type, class_name: "TaxType"

      has_many :addresses
      has_many :contacts
      has_many :notes

      attribute :name,                   String
      attribute :description,            String
      attribute :company_code,           String
      attribute :phone_number,           String
      attribute :fax,                    String
      attribute :email,                  String
      attribute :website,                String
      attribute :company_type,           String

      attribute :status,                 String, readonly: true

      attribute :tax_number,             String

      attribute :default_tax_rate,       BigDecimal
      attribute :default_discount_rate,  BigDecimal

      # belongs_to :default_price_list,   class_name: "PriceList"
      # belongs_to :default_payment_term, class_name: "PaymentTerm"
    end

    class CompanyAdapter < BaseAdapter
      # Override plural_path to properly pluralize company
      def plural_path
        'companies'
      end
    end
  end
end
