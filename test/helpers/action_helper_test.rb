# frozen_string_literal: true

require 'gecko'

class Gecko::Helpers::ActionHelperTest < Minitest::Test
  def setup
    @klass = Class.new(Gecko::Record::Base) do
      action :fire
    end
    @client = Gecko::Client.new('ABC', 'DEF')
  end

  def test_adds_action_methods
    record = @klass.new(@client, {})
    assert(record.respond_to?(:fire))
  end
end
