# frozen_string_literal: true

# Including this file enhances every Gecko::Record object to support the Liquid::Drop API.
#
# @example
#   template = Liquid::Template.parse("{{variant.sku}}")
#   rendered = template.render('variant' => client.Variant.find(123))
module Gecko
  # Monkey-patches the base record class with a `to_liquid` method
  module LiquidCompatibility
    # The Liquid templating library automatically uses a `to_liquid` method if found.
    def to_liquid
      liquid_decorator.new(self)
    end

  private

    # If you'd like to add custom behviour per-record-type,
    # override this method and return a subclass.
    #
    # @example
    #
    #   module MyLiquidCompat
    #     def liquid_decorator
    #       "#{self.class.demodulized_name}Decorator".safe_constantize || BaseDecorator
    #     end
    #   end
    #
    #   Gecko::Record::Base.include(MyLiquidCompat)
    def liquid_decorator
      Gecko::BaseDecorator
    end
  end

  Gecko::Record::Base.include(LiquidCompatibility)
  Gecko::Helpers::CollectionProxy.delegate(:to_liquid, to: :@target)

  class BaseDecorator < Liquid::Drop
    def initialize(delegate)
      raise 'Turtles all the way down' if delegate.is_a?(BaseDecorator)

      @delegate = delegate
    end

    def method_missing(method_name, *args, &block)
      if @delegate.respond_to?(method_name)
        @delegate.public_send(method_name, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      @delegate.respond_to?(method_name) || super
    end

    ## Override Liquid::Drop#invoke_drop to also check method arity
    def invoke_drop(method_or_key)
      if self.invokable_methods.include?(method_or_key.to_s) && self.method_arity(method_or_key.to_sym) <= 0
        self.public_send(method_or_key)
      end
    end

    ## Override Liquid::Drop#invokable_methods to add extra checks
    def invokable_methods
      @invokable_methods ||= begin
        blacklist = Gecko::Record::Base.public_instance_methods + Liquid::Drop.public_instance_methods
        blacklist -= [:to_liquid, :id, :created_at, :updated_at]
        whitelist = self.public_methods + @delegate.public_methods
        available_methods = (whitelist - blacklist).map(&:to_s)
        available_methods.reject! { |method_name| method_name.ends_with?("=") }
        Set.new(available_methods)
      end
    end

  protected

    def method_arity(method_name)
      if self.methods.include?(method_name)
        self.method(method_name).arity
      else
        @delegate.method(method_name).arity
      end
    end

    def client
      @delegate.instance_variable_get(:@client)
    end
  end
end
