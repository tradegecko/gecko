module SharedRecordExamples
  def test_sets_up_id
    assert_instance_of(Fixnum, @record.id)
    assert_equal(@json['id'], @record.id)
  end

  def test_persisted?
    assert record_class.new(client, id: 123).persisted?
    assert !record_class.new(client, {}).persisted?
    assert !record_class.new(client).persisted?
  end

  def test_saving
    @client.adapter_for(record_class.demodulized_name).expects(:save).with(@record, {})
    @record.save
  end

  def client
    @client ||= Gecko::Client.new('ABC', 'DEF')
  end
end
