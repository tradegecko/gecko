require 'gecko/record/base'

module Gecko
  module Record
    class User < Base
      attribute :first_name,         String
      attribute :last_name,          String
      attribute :email,              String
      attribute :location,           String
      attribute :position,           String
      attribute :phone_number,       String
      attribute :mobile_phone,       String
      attribute :last_sign_in_at,    DateTime
      attribute :avatar_url,         String

      attribute :status,             String

      # attribute :sales_report_email, Boolean
      # attribute :action_items_email, String

      # attribute :billing_contact,    Boolean
      # attribute :notification_email, Boolean
      # attribute :permisssions,       Array[String]
      # attribute :account_id,         Integer
    end

    class UserAdapter < BaseAdapter
      undef :count
    end
  end
end
