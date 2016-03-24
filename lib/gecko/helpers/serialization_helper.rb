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
      def _serialize(serialized)
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
    end
  end
end
