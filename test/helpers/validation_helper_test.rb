# frozen_string_literal: true

require 'gecko'

class Gecko::Helpers::ValidationHelperTest < Minitest::Test
  def setup
    @klass = Class.new(Gecko::Record::Base) do
      attribute :name,   String
    end
    @client = Gecko::Client.new('ABC', 'DEF')
  end

  def test_initially_valid?
    record = @klass.new(@client, name: "Gecko")
    assert(record.valid?)
    assert(record.errors.empty?)
    assert(record.errors.messages.empty?)
  end

  def test_from_response
    record = @klass.new(@client, name: "Gecko")
    record.errors.from_response({ name: ["is not shiny"] })
    assert(!record.valid?)
    assert_equal(record.errors[:name], ["is not shiny"])
  end
end
