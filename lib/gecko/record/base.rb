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

      # Returns The original attribute hash before coercion
      #
      # @return [Hash]
      #
      # @api public
      attr_reader :data

      # Overrides the default Virtus functionality to store:
      # - The Gecko::Client used to create the object
      # - a raw copy of the attributes for the association helpers to read from
      # @return [undefined]
      #
      # @api private
      def initialize(client, attributes)
        super(attributes)
        @client   = client
        @data = symbolize_keys(attributes)
      end

      # Set up the default attributes associated with all records
      attribute :id,               Integer
      attribute :updated_at,       DateTime
      attribute :created_at,       DateTime

    private
      # Symbolizes the first level of keys in a hash
      # Modified from ActiveSupport gem
      #
      # @example
      #   symbolize_keys({"peter" => "pan"}) #=> {peter: "pan"}
      #
      # @return [Hash]
      #
      # @api private
      def symbolize_keys(attribute_hash)
        new_hash = attribute_hash.dup
        new_hash.keys.each do |key|
          new_hash[(key.to_sym rescue key) || key] = new_hash.delete(key)
        end
        new_hash
      end
    end
  end
end
