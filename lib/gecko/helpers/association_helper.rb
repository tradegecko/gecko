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
        def belongs_to(model_name, options={})
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
        # @option options [String] :readonly (true) Whether to serialize this
        #   attribute
        #
        # @return [undefined]
        #
        # @api public
        def has_many(association_name, options={})
          model_name = association_name.to_s.singularize
          class_name = options[:class_name] || model_name.classify
          foreign_key = model_name.foreign_key.pluralize.to_sym
          readonly    = options.key?(:readonly) ? options[:readonly] : true

          define_method association_name do
            ids = self.attributes[foreign_key]
            if ids.any?
              @client.adapter_for(class_name).find_many(ids)
            else
              []
            end
          end
          attribute foreign_key, Array[Integer], readonly: readonly
        end
      end
    end
  end
end
