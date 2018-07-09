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
    assert_empty(record.orders)
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

  def test_building_a_new_embedded_item
    record = @client.Order.build({})
    embedded = record.order_line_items.build(quantity: 1, variant_id: 1)
    assert_instance_of(Gecko::Record::OrderLineItem, embedded)
    assert_nil(embedded.order_id)
    assert_instance_of(Gecko::Record::OrderLineItem, embedded)
    assert(!embedded.persisted?)
    assert_includes(record.order_line_items, embedded)
    skip("This hasn't been implemented for fresh records yet")
    assert_equal(record, embedded.order)
  end

  def test_building_a_new_embedded_item_on_existing_record
    record = @client.Order.instantiate_and_register_record(id: 123)
    embedded = record.order_line_items.build(quantity: 1, variant_id: 1)
    assert_instance_of(Gecko::Record::OrderLineItem, embedded)
    assert_equal(123, embedded.order_id)
    assert_instance_of(Gecko::Record::OrderLineItem, embedded)
    assert(!embedded.persisted?)
    assert_includes(record.order_line_items, embedded)
    assert_equal(record, embedded.order)
  end
end
