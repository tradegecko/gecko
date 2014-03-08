require 'gecko/record/base'

module Gecko
  module Record
    class Address < Base
      belongs_to :company

      attribute :phone_number, String
      attribute :email,        String

      attribute :label,        String
      attribute :company_name, String
      attribute :address1,     String
      attribute :address2,     String
      attribute :suburb,       String
      attribute :city,         String
      attribute :state,        String
      attribute :country,      String
      attribute :zip_code,     String

      attribute :status,       String,  readonly: true

      alias_method :country_code, :country
    end

    class AddressAdapter < BaseAdapter
      undef :count

      # Override plural_path to properly pluralize address
      def plural_path
        "addresses"
      end
    end
  end
end
