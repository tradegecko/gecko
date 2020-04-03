# frozen_string_literal: true

module Gecko
  module Helpers
    # Helper for has_many/belongs_to relationships
    module AssociationHelper
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        # Set up a belongs_to relationship between two classes based on a
        # JSON key of {class_name}_id.
        #
        # @example
        #   class Gecko::Record::Variant
        #     belongs_to :product
        #   end
        #
        # @param [Symbol] model_name
        # @param [#to_hash] options options for setting up the relationship
        # @option options [String] :class_name Override the default class name
        # @option options [String] :readonly (false) Whether to serialize
        #   this attribute
        #
        # @return [undefined]
        #
        # @api public
        def belongs_to(model_name, options = {})
          class_name  = options[:class_name] || model_name.to_s.classify
          foreign_key = model_name.to_s.foreign_key.to_sym

          define_method model_name do
            if (id = attributes[foreign_key])
              @client.adapter_for(class_name).find(id)
            end
          end
          attribute foreign_key, Integer, readonly: options[:readonly]
        end

        # Set up a has_many relationship between two classes based on a
        # JSON key of {class_name}_ids.
        #
        # @example
        #   class Gecko::Record::Product
        #     has_many :variants
        #   end
        #
        # @param [Symbol] model_name
        # @param [#to_hash] options options for setting up the relationship
        # @option options [String] :class_name Override the default class name
        # @option options [Boolean] :readonly (true) Whether to serialize this
        #   attribute
        # @option options [Boolean] :embedded (false) Whether this relation should
        #   persisted inside it's parent record
        #
        # @return [undefined]
        #
        # @api public
        def has_many(association_name, options = {}) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          model_name = association_name.to_s.singularize
          class_name = options[:class_name] || model_name.classify
          foreign_key = model_name.foreign_key.pluralize.to_sym
          readonly    = options.key?(:readonly) ? options[:readonly] : true

          define_method association_name do # rubocop:disable Metrics/MethodLength
            collection_proxies[association_name] ||= begin
              ids = attributes[foreign_key]
              collection = if ids.any?
                             @client.adapter_for(class_name).find_many(ids)
                           else
                             []
                           end

              build_collection_proxy(collection, {
                embedded:         options[:embedded],
                class_name:       class_name,
                association_name: association_name
              })
            end
          end
          attribute foreign_key, Array[Integer], readonly: readonly
        end
      end

    private

      # Stores a reference to all of the child collection proxies on the model
      #
      # @return [Hash]
      #
      # @api private
      def collection_proxies
        @collection_proxies ||= {}
      end

      # Setup a child collection proxy on first instantation
      #
      # @return [Hash]
      #
      # @api private
      def build_collection_proxy(target, association_name:, class_name:, embedded:)
        CollectionProxy.new({
          parent:           self,
          target:           target,
          embedded:         embedded,
          class_name:       class_name,
          association_name: association_name
        })
      end
    end

    # Provides a convenient wrapper for a collection of child records.
    # Exposes both an Enumerable interface as well as the ability
    # to create new child records
    class CollectionProxy
      include Enumerable
      delegate :each, :empty?, to: :@target

      attr_reader :association_name, :parent

      # Setup the child collection proxy
      #
      # @return [Hash]
      #
      # @api private
      def initialize(parent:, association_name:, class_name:, target:, embedded:)
        @parent           = parent
        @target           = target
        @embedded         = embedded
        @class_name       = class_name
        @association_name = association_name
      end

      # Build a new child object inside the collection
      #
      # @example
      #   item = order.order_line_items.build(variant_id: 1234, quantiy: 12.5, price: 13.45)
      #   order.order_line_items.include?(item) #=> true
      #
      # @param [#to_hash] attributes for the child record
      #
      # @return [Gecko::Record::Base]
      #
      # @api public
      def build(attributes)
        if @parent.persisted?
          parent_foreign_key = @parent.class.demodulized_name.foreign_key.to_sym
          attributes[parent_foreign_key] = @parent.id
        end

        record = client.adapter_for(@class_name).build(attributes)
        @target << record
        record
      end

      # Should this collection of records be serialized inside it's parent object
      #
      # @return [Boolean]
      #
      # @api private
      def embed_records?
        !!@embedded
      end

    private

      # Access the Gecko Client object
      #
      # @return [Gecko::Client]
      #
      # @api private
      def client
        @parent.instance_variable_get(:@client)
      end
    end
  end
end
