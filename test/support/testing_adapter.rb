# frozen_string_literal: true

module TestingAdapter
  require 'dotenv'
  def setup
    Dotenv.load
    @client = Gecko::Client.new(ENV["OAUTH_ID"], ENV["OAUTH_SECRET"], {
      site:          'http://api.lvh.me:3000',
      authorize_url: 'http://go.lvh.me:3000/oauth/authorize'
    })
    @client.authorize_from_existing(ENV["ACCESS_TOKEN"], ENV["REFRESH_TOKEN"], Time.at(ENV["EXPIRES_AT"].to_i))
  end
end
