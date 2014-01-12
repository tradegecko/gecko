require 'test_helper'

class ClientTest < Minitest::Test
  def setup
    @client = Gecko::Client.new("ABC", "DEF")
  end

  def test_setup_oauth_client
    oauth = @client.oauth_client
    assert_instance_of OAuth2::Client, oauth
    assert_equal oauth.site, "https://api.tradegecko.com"
    assert_equal oauth.id, "ABC"
    assert_equal oauth.secret, "DEF"
  end

  def test_authorizing_from_existing
    @client.authorize_from_existing("GHI", "JKL", 123456)
    assert_instance_of OAuth2::AccessToken, @client.access_token
  end
end


