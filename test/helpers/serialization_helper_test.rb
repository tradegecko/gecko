require 'gecko'

class Gecko::Helpers::SerializationHelperTest < Minitest::Test
  def setup
    @klass = Class.new(Gecko::Record::Base) do
      attribute :name,   String
      attribute :secret, String, readonly: true

      def root
        :widget
      end
    end
    @client = Gecko::Client.new('ABC', 'DEF')
  end

  def test_serializable_hash
    record = @klass.new(@client, name: "Gecko", secret: "Iguana")
    assert_equal({name: "Gecko"}, record.serializable_hash)
  end

  def test_as_json
    record = @klass.new(@client, name: "Gecko", secret: "Iguana")
    assert_equal({widget: {name: "Gecko"}}, record.as_json)
  end

  def test_root_key
    record = Gecko::Record::OrderLineItem.new(@client, @json)
    assert_equal(:order_line_item, record.root)
  end
end
