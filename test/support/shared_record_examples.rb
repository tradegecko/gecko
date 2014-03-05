module SharedRecordExamples
  def test_sets_up_id
    assert_instance_of(Fixnum, @record.id)
    assert_equal(@json["id"], @record.id)
  end
end
