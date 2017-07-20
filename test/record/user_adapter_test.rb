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

  # Can't build users via API
  undef :test_build
  undef :test_build_with_attributes
  undef :test_saving_new_record
  undef :test_saving_new_invalid_record
  undef :test_saving_record_with_idempotency_key

  def test_current
    VCR.use_cassette('users#current') do
      assert_instance_of(Gecko::Record::User, @client.User.current)
      assert(@client.User.current, 'User.current is identity mapped')
    end
  end
end
