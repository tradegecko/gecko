module Gecko
  module Helpers
    module RecordHelper
      # Registers a record type on the Gecko::Client
      #
      # @example
      #  class Gecko::Client
      #   record :Invoice
      #  end
      #
      # @return [undefined]
      #
      # @api private
      def record(record_type)
        define_method record_type do
          adapter_cache = "@#{record_type}_cache".to_sym
          unless instance_variable_defined?(adapter_cache)
            adapter_klass = Gecko::Record.const_get("#{record_type}Adapter".to_sym)
            self.instance_variable_set(adapter_cache, adapter_klass.new(self, record_type))
          end
          instance_variable_get(adapter_cache)
        end
      end
    end
  end
end



