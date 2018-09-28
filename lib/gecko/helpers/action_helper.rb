# frozen_string_literal: true

module Gecko
  module Helpers
    # Helper for actions
    module ActionHelper
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        # Creates an action that allows a record class to perform that specific action.
        #
        # @example
        #   class Gecko::Record::Order
        #     action :invoice
        #   end
        #
        # @param [Symbol] action
        #
        # @return [Boolean]
        #
        # @api public
        def action(action_name)
          define_method action_name do
            name = self.class.demodulized_name
            @client.adapter_for(name).action(self, action_name)
          end
        end
      end
    end
  end
end
