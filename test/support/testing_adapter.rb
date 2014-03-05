module TestingAdapter
  ACCESS_TOKEN  = "3cbe8bf9be5a8a34242b9e38744e5e2696088a3f7b18d34854fa031f3c7c342e"
  REFRESH_TOKEN = "e8c693d0942f383c7ce61d3bbd045aeec3f3d91a37c8873f9ac0a2e952a91cef"
  EXPIRES_AT    = 1393982563

  def setup
    @client = Gecko::Client.new(ENV["OAUTH_ID"], ENV["OAUTH_SECRET"], {
      site:          'http://api.lvh.me:3000',
      authorize_url: 'http://go.lvh.me:3000/oauth/authorize'
    })
    @client.authorize_from_existing(ACCESS_TOKEN, REFRESH_TOKEN, Time.at(EXPIRES_AT))
  end
end
