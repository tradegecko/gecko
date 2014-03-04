require 'oauth2'

module Gecko
  class Client
    attr_reader :oauth_client
    attr_accessor :access_token

    def initialize(client_id, client_secret, options={})
      setup_oauth_client(client_id, client_secret, options)
    end

    def authorize_from_existing(access_token, refresh_token, expires_at)
      @access_token = OAuth2::AccessToken.new(oauth_client, access_token, {
        refresh_token: refresh_token,
        expires_at:    expires_at
      })
    end

    def authorize_from_refresh_token(refresh_token)
      @access_token = oauth_client.get_token({
        client_id:     oauth_client.id,
        client_secret: oauth_client.secret,
        refresh_token: refresh_token,
        grant_type:    'refresh_token'
      })
    end

  private
    def setup_oauth_client(client_id, client_secret, options)
      defaults = {
        site:          'https://api.tradegecko.com',
        authorize_url: 'https://go.tradegecko.com/oauth/authorize'
      }
      @oauth_client = OAuth2::Client.new(client_id, client_secret, defaults.merge(options))
    end
  end
end
