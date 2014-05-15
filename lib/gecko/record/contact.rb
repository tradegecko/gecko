require 'gecko/record/base'

module Gecko
  module Record
    class Contact < Base
      belongs_to :company

      attribute :email,        String
      attribute :first_name,   String
      attribute :last_name,    String
      attribute :location,     String
      attribute :mobile,       String
      attribute :notes,        String
      attribute :phone_number, String
      attribute :fax,          String
      attribute :position,     String
      attribute :phone,        String

      attribute :status,       String
    end

    class ContactAdapter < BaseAdapter
    end
  end
end
