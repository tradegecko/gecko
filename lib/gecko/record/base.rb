require 'gecko/helpers/association_helper'
require 'gecko/helpers/inspection_helper'
require 'virtus'
require 'active_support/inflector'
require 'active_support/core_ext/hash/keys'

module Gecko
  module Record
    class Base
      extend  Gecko::Helpers::AssociationHelper
      include Gecko::Helpers::InspectionHelper
      include Virtus.model

      # Overrides the default Virtus functionality to store:
      # - The Gecko::Client used to create the object
      # - a raw copy of the attributes for the association helpers to read from
      # @return [undefined]
      #
      # @api private
      def initialize(client, attributes)
        super(attributes)
        @client   = client
      end

      # Set up the default attributes associated with all records
      attribute :id,               Integer
      attribute :updated_at,       DateTime
      attribute :created_at,       DateTime
    end
  end
end
