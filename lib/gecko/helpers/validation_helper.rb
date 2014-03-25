module Gecko
  module Helpers
    module ValidationHelper

      # Returns whether a record is considered valid or not
      #
      # @return [Boolean]
      #
      # @api public
      def valid?
        errors.empty?
      end

      # Returns the validation errors object for the record
      #
      # @return [Gecko::Errors]
      #
      # @api public
      def errors
        @errors ||= Gecko::Errors.new(self)
      end
    end
  end

  class Errors
    # The hash of errors for this record
    #
    # @return [Hash]
    #
    # @api public
    attr_reader :messages

    # Set up the error object
    #
    # @api private
    def initialize(base)
      @base     = base
      @messages = {}
    end

    # Fetch the errors for a specific attribute
    #
    # @example
    #   product.errors[:name]
    #     #=> ["can't be blank"]
    #
    # @params [Symbol] :attribute
    #
    # @return [Array]
    #
    # @api public
    def [](attribute)
      messages[attribute.to_sym]
    end

    # Clear the validation errors
    #
    # @example
    #   product.errors.clear
    #
    # @return [undefined]
    #
    # @api public
    def clear
      @messages.clear
    end

    # Whether there are any errors
    #
    # @return [Boolean]
    #
    # @api public
    def empty?
      messages.all? { |k, v| v && v.empty? && !v.is_a?(String) }
    end

    # Parse JSON errors response into the error object
    #
    # @params [#to_hash] :error_hash hash of errors where key is an attribute name
    #                                and value is an array of error strings
    #
    # @return [undefined]
    #
    # @api private
    def from_response(error_hash)
      error_hash.each do |attr, errors|
        @messages[attr.to_sym] = errors
      end
    end
  end
end
