require 'gecko/helpers/association_helper'
require 'gecko/helpers/inspection_helper'

module Gecko
  module Record
    class Base
      include Virtus.model
      extend  Gecko::Helpers::AssociationHelper
      include Gecko::Helpers::InspectionHelper

      # Set up the default attributes associated with all records
      attribute :id,          Integer,    readonly: true
      attribute :updated_at,  DateTime,   readonly: true
      attribute :created_at,  DateTime,   readonly: true

      # Overrides the default Virtus functionality to store:
      # - The Gecko::Client used to create the object
      # - a raw copy of the attributes for the association helpers to read from
      # @return [undefined]
      #
      # @api private
      def initialize(client, attributes={})
        super(attributes)
        @client   = client
      end

      # Whether the record has been persisted
      #
      # @example
      #   variant.persisted? #=> true
      #
      # @return <Boolean>
      #
      # @api public
      def persisted?
        !!id
      end
    end
  end
end
