require 'test_helper'

class ClientTest < Minitest::Test
  def test_initializes_oauth_client
    client       = Gecko::Client.new("ABC", "DEF")
    oauth_client = client.oauth_client
    assert_instance_of OAuth2::Client, oauth_client
    assert_equal "https://api.tradegecko.com", oauth_client.site
    assert_equal "ABC", oauth_client.id
    assert_equal "DEF", oauth_client.secret
  end

  def test_custom_user_agent
    client  = Gecko::Client.new("ABC", "DEF")
    agent   = client.oauth_client.connection.headers["User-Agent"]
    assert_match(%r|Gecko/#{Gecko::VERSION} OAuth2/\d\.\d\.\d Faraday/\d\.\d+\.\d Ruby/\d\.\d\.\d|, agent)
  end

  def test_allows_test_URLs
    client = Gecko::Client.new("ABC", "DEF", site: "localhost:3000")
    assert_equal "localhost:3000", client.oauth_client.site
  end

  def test_instantiates_base_adapter
    client = Gecko::Client.new("ABC", "DEF")
    assert_instance_of Gecko::Record::FulfillmentAdapter, client.Fulfillment
    assert_equal client.Fulfillment, client.Fulfillment
  end
end
