require 'gecko/record/base'

module Gecko
  module Record
    class Company < Base
      belongs_to :assignee,               class_name: "User"
      belongs_to :default_tax_type,       class_name: "TaxType"
      belongs_to :default_payment_term,   class_name: "PaymentTerm"
      belongs_to :default_stock_location, class_name: "Location"
      # belongs_to :default_price_list,   class_name: "PriceList"
      attribute :default_price_list_id,  String
      # belongs_to :default_ledger_account
      attribute :default_ledger_account_id,  Integer

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
      attribute :tags,                   Array[String]

      attribute :status,                 String

      attribute :tax_number,             String

      attribute :default_discount_rate,  BigDecimal
      attribute :default_tax_rate,       BigDecimal, readonly: true
    end

    class CompanyAdapter < BaseAdapter
      # Override plural_path to properly pluralize company
      def plural_path
        'companies'
      end
    end
  end
end
