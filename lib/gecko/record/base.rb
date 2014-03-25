require 'gecko/helpers/association_helper'
require 'gecko/helpers/inspection_helper'
require 'gecko/helpers/serialization_helper'
require 'gecko/helpers/validation_helper'

module Gecko
  module Record
    class Base
      include Virtus.model
      extend  Gecko::Helpers::AssociationHelper
      include Gecko::Helpers::InspectionHelper
      include Gecko::Helpers::SerializationHelper
      include Gecko::Helpers::ValidationHelper

      # Set up the default attributes associated with all records
      attribute :id,          Integer,    readonly: true
      attribute :updated_at,  DateTime,   readonly: true
      attribute :created_at,  DateTime,   readonly: true

      # Overrides the default Virtus functionality to store:
      # - The Gecko::Client used to create the object
      # - a raw copy of the attributes for the association helpers to read from
      #
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

      # Save a record
      #
      # @return <Gecko::Record::Base>
      #
      # @api public
      def save
        @client.adapter_for(self.class.demodulized_name).save(self)
      end

      # Return the demodulized class name
      #
      # @example
      #   Gecko::Record::Product.demodulized_name #=> "Product"
      #
      # @return [String]
      #
      # @api private
      def self.demodulized_name
        self.name.split("::").last
      end
    end
  end
end
