require 'gecko'

class Gecko::Helpers::AssociationHelperTest < Minitest::Test
  def setup
    @klass = Class.new(Gecko::Record::Base) do
      has_many :orders
      belongs_to :order
      belongs_to :small_order, class_name: "Order"
    end
    @client = Gecko::Client.new('ABC', 'DEF')
  end

  def test_adds_association_methods
    record = @klass.new(@client, {})
    assert(record.respond_to?(:orders))
    assert(record.respond_to?(:order))
    assert(record.respond_to?(:small_order))
  end

  def test_adds_id_methods
    record = @klass.new(@client, {})
    assert(record.respond_to?(:order_ids))
    assert(record.respond_to?(:order_id))
    assert(record.respond_to?(:small_order_id))
  end

  def test_has_many
    record = @klass.new(@client, {order_ids: [123]})
    @client.Order.expects(:find_many).with([123])
    record.orders
  end

  def test_has_many_without_ids
    record = @klass.new(@client, {order_ids: []})
    @client.Order.expects(:find_many).never
    assert_equal([], record.orders)
  end

  def test_belongs_to
    record = @klass.new(@client, {order_id: 4})
    @client.Order.expects(:find).with(4)
    record.order
  end

  def test_belongs_to_without_id
    record = @klass.new(@client, {order_id: nil})
    @client.Order.expects(:find).never
    assert_nil record.order
  end

  def test_belongs_to_with_class
    record = @klass.new(@client, {small_order_id: 56})
    @client.Order.expects(:find).with(56)
    record.small_order
  end
end
