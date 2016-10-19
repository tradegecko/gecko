require 'gecko'
require 'test_helper'

class Gecko::Helpers::SerializationHelperTest < Minitest::Test
  Wodget = Class.new(Gecko::Record::Base) do
    attribute :name, String

    def root
      :wodget
    end
  end

  Widget = Class.new(Gecko::Record::Base) do
    attribute :name,       String
    attribute :secret,     String,       readonly: true
    attribute :initial_stock, BigDecimal, writeable_on: :create
    attribute :update_stock, BigDecimal, writeable_on: :update
    attribute :score,      BigDecimal
    attribute :started_on, Date
    attribute :started_at, DateTime
    attribute :wodgets,    Array[Wodget]

    def root
      :widget
    end
  end

  let(:record) do
    Widget.new(@client, {
      name:       "Gecko",
      secret:     "Iguana",
      initial_stock: 10.0,
      update_stock: 10.0,
      score:      1.234,
      started_at: DateTime.now,
      started_on: Date.today,
      wodgets:    [Wodget.new(@client, name: "Hi")]
    })
  end

  def setup
    Timecop.freeze
    @client = Gecko::Client.new("ABC", "DEF")
  end

  def teardown
    Timecop.return
  end

  def test_as_json
    assert_equal({widget: record.serializable_hash}, record.as_json)
  end

  def test_writeable_on_create
    assert_equal(serialized_record, record.serializable_hash)
  end

  def test_writeable_on_update
    cleaned_record = serialized_record
    cleaned_record.delete(:initial_stock)
    cleaned_record[:update_stock] = "10.0"
    record.id = 1
    assert_equal(cleaned_record, record.serializable_hash)
  end

  def test_serializable_hash
    assert_equal(serialized_record, record.serializable_hash)
  end

  def test_serializes_big_decimal_in_math_notation
    assert_equal("1.234", record.serializable_hash[:score])
  end

  def test_serializes_arrays
    assert_equal([{name: "Hi"}], record.serializable_hash[:wodgets])
  end

  def test_root_key
    record = Gecko::Record::OrderLineItem.new(@client, {})
    assert_equal(:order_line_item, record.root)
  end

private

  def serialized_record
    {
      name:       "Gecko",
      initial_stock: "10.0",
      score:      "1.234",
      started_on: Date.today,
      started_at: DateTime.now,
      wodgets:    [{name: "Hi"}]
    }
  end
end
