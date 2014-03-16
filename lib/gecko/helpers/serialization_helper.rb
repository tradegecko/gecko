module Gecko
  module Helpers
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
          next if attribute.options[:readonly]
          serialize_attribute(attribute_hash, attribute)
        end
        attribute_hash
      end

      # Serialize a single attribute
      #
      # @param [Hash] attribute_hash Serialized record being iterated over
      # @param [Virtus::Attribute] attribute The attribute being serialized
      #
      # @return [undefined]
      #
      # @api private
      def serialize_attribute(attribute_hash, attribute)
        attribute_hash[attribute.name] = attributes[attribute.name]
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
