require 'gecko/record/base'

module Gecko
  module Record
    class Channel < Base
      attribute :active,                 Boolean
      attribute :application_id,         Integer
      attribute :last_fetched_at,        Date
      attribute :manage_variant_details, Boolean
      attribute :name,                   String
      attribute :price_list_id,          String
      attribute :publishable,            Boolean
      attribute :redirect_url,           String
      attribute :sale_price_list_id,     String
      attribute :site_url,               String
      attribute :stock_location_id,      Integer
      attribute :type,                   String
    end

    class ChannelAdapter < BaseAdapter
    end
  end
end
