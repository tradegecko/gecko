# frozen_string_literal: true

require 'gecko'

class Gecko::Helpers::InspectionHelperTest < Minitest::Test
  def setup
    @klass = Class.new(Gecko::Record::Base) do
      attribute :published_date,     Date
      attribute :published_datetime, DateTime
      attribute :published_time,     Time
    end
    @client = Gecko::Client.new('ABC', 'DEF')
  end

  def test_inspect_times
    record = @klass.new(@client, {
      published_date:     Date.new(2014),
      published_time:     Time.new(2014),
      published_datetime: DateTime.new(2014)
    })
    assert_equal("2014-01-01 00:00:00", get_timestamp(record.inspect, :published_time))
    assert_equal("2014-01-01 00:00:00", get_timestamp(record.inspect, :published_datetime))
    assert_equal("2014-01-01",          get_timestamp(record.inspect, :published_date))
  end

  def get_timestamp(inspect_string, attribute)
    inspect_string.match(/#{attribute}: \"(?<timestamp>[\d:\s-]+)\"/)[:timestamp]
  end
end
