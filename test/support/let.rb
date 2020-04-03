# frozen_string_literal: true

module Minitest
  module Let
    def let(name, &block)
      define_method(name) do
        @_memoized ||= {}
        @_memoized.fetch(name) { |k| @_memoized[k] = instance_eval(&block) }
      end
    end
  end
end
