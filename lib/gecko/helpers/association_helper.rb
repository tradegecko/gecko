module Gecko
  module Helpers
    module AssociationHelper
      # Set up a belongs_to relationship between two classes based on a JSON key of
      # {class_name}_id.
      #
      # @example
      #   class Gecko::Record::Variant
      #     belongs_to :product
      #   end
      #
      # @param [Symbol]   model_name
      # @param [#to_hash] options the options
      # @option options [String] :class_name Override the default class name
      #
      # @return [undefined]
      #
      # @api public
      def belongs_to(model_name, options={})
        class_name = options[:class_name] || model_name.to_s.classify
        define_method model_name do
          id = @data[model_name.to_s.foreign_key.to_sym]
          if id
            @client.public_send(class_name).find(id)
          end
        end
      end

      # Set up a has_many relationship between two classes based on a JSON key of
      # {class_name}_ids.
      #
      # @example
      #   class Gecko::Record::Product
      #     has_many :variants
      #   end
      #
      # @param [Symbol]   model_name
      # @param [#to_hash] options the options
      # @option options [String] :class_name Override the default class name
      #
      # @return [undefined]
      #
      # @api public
      def has_many(association_name, options={})
        model_name = association_name.to_s.singularize
        class_name = options[:class_name] || model_name.classify
        define_method association_name do
          ids = @data[model_name.foreign_key.pluralize.to_sym]
          if ids.any?
            @client.public_send(class_name).find_many(ids)
          else
            []
          end
        end
      end
    end
  end
end



