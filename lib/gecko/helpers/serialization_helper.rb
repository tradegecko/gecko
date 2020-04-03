# frozen_string_literal: true

module Gecko
  module Helpers
    # Provides serialization to records
    module SerializationHelper
      # Returns a full JSON representation of a record
      #
      # @example
      #   product.as_json #=> {product: {id: 12, name: "Big"}}
      #
      # @return [Hash]
      #
      # @api private
      def as_json
        {
          root => serializable_hash
        }
      end

      # Return a serialized hash of the record's attributes
      #
      # @example
      #   product.serializable_hash #=> {id: 12, name: "Big"}
      #
      # @return [Hash]
      #
      # @api private
      def serializable_hash
        attribute_hash = {}
        attribute_set.each do |attribute|
          next unless writeable?(attribute)

          serialize_attribute(attribute_hash, attribute)
        end

        embedded_collections_for_serialization.each do |collection|
          serialize_new_records(attribute_hash, collection)
        end

        attribute_hash
      end

      # Returns true if an attribute can be serialized
      #
      # @return [Boolean]
      #
      # @api private
      def writeable?(attribute)
        return if attribute.options[:readonly]
        return true unless attribute.options[:writeable_on]

        case attribute.options[:writeable_on]
        when :update
          persisted?
        when :create
          !persisted?
        else
          raise ArgumentError
        end
      end

      # Store the serialized representation of a single attribute
      #
      # @param [Hash] attribute_hash Serialized record being iterated over
      # @param [Virtus::Attribute] attribute The attribute being serialized
      #
      # @return [undefined]
      #
      # @api private
      def serialize_attribute(attribute_hash, attribute)
        attribute_hash[attribute.name] = _serialize(attributes[attribute.name])
      end

      # Serialize an attribute
      #
      # @param [Object] serialized The attribute to serialize
      #
      # @return [String]
      #
      # @api private
      def _serialize(serialized) # rubocop:disable Metrics/MethodLength
        if serialized.respond_to?(:serializable_hash)
          serialized.serializable_hash
        else
          case serialized
          when Array
            serialized.map { |attr| _serialize(attr) }
          when BigDecimal
            serialized.to_s("F")
          else
            serialized
          end
        end
      end

      # Return JSON root key for a record
      #
      # @example
      #   product.root #=> "product"
      #
      # @return [String]
      #
      # @api private
      def root
        self.class.demodulized_name.underscore.to_sym
      end

    private

      # Returns embedded collections
      #
      # @return [Array<Gecko::Helpers::CollectionProxy>]
      #
      # @api private
      def embedded_collections_for_serialization
        collection_proxies.values.select(&:embed_records?)
      end

      # Serialize newly built embedded records into the payload
      #
      # @return [undefined]
      #
      # @api private
      def serialize_new_records(serialized, collection_proxy)
        new_records = collection_proxy.reject(&:persisted?)
        return unless new_records.any?

        parent_key = collection_proxy.parent.class.demodulized_name.foreign_key.to_sym

        serialized[collection_proxy.association_name] = new_records.map do |record|
          record.serializable_hash.except(parent_key)
        end
      end
    end
  end
end
