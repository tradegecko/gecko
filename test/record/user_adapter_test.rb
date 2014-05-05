require 'test_helper'

class Gecko::Record::UserAdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.User }
  let(:plural_name)   { 'users' }
  let(:record_class)  { Gecko::Record::User }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::UserAdapter, @client.User)
  end

  undef :test_adapter_count
end
