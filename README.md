# TradeGecko RubyGem [![Build Status](https://travis-ci.org/tradegecko/gecko.png)](https://travis-ci.org/tradegecko/gecko)
The official TradeGecko API RubyGem

## Introduction

This library provides a Ruby interface to publicly available (beta) API for TradeGecko.

If you are unfamiliar with the TradeGecko API, you can read the documentation located at [http://developer.tradegecko.com](http://developer.tradegecko.com)

## Installation

Add this line to your application's Gemfile:

    gem 'gecko'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gecko

## Basic Usage

```ruby
client = Gecko::Client.new(CLIENT_ID, CLIENT_SECRET)
client.access_token = existing_access_token

products = client.Product.where(q: "Gecko")
#=> [<Gecko::Record::Product id=1 name="Geckotron">, <Gecko::Record::Product id=3 name="Green Gecko">]
```

## Finding Records

#### Basic finders
```ruby
client.Product.find(123)
#=> <Gecko::Record::Product id=123 name="Geckotron">
client.Product.find_many(123, 124)
#=> [<Gecko::Record::Product id=123 name="Geckotron">, <Gecko::Record::Product id=124 name="Salamander">
client.Product.where(ids: [123, 124])
#=> [<Gecko::Record::Product id=123 name="Geckotron">, <Gecko::Record::Product id=124 name="Salamander">
```

#### Identity Map

The Gecko gem ships with a basic identity map

```ruby
client.Product.find(123)
# Makes an API request

client.Product.find(123)
# Returned from identity map on second request, no API request

client.Product.fetch(123)
# Does not use identity map and makes request regardless

client.Product.find_many([123, 124])
# Will return 123 from memory and make request for 124

client.Product.where(ids: [123, 124])
# Does not use identity map and makes request regardless
```

## Building Records

```ruby
geckobot = client.Product.build(name: "Geckobot", product_type: "Robot")
#=> <Gecko::Record::Product id=nil name="Geckobot" product_type: "Robot">
geckobot.persisted?
#=> false
```

## Persisting Records (WIP)

#### Create Record

```ruby
geckobot = client.Product.build(name: "Geckobot", product_type: "Robot")
#=> <Gecko::Record::Product id=nil name="Geckobot" product_type: "Robot">
geckobot.persisted?
#=> false
geckobot.save # Persists to API
#=> true
geckobot
#=> <Gecko::Record::Product id=124 name="Geckobot" product_type: "Robot">
```

#### Update Record

```ruby
geckobot = client.Product.find(124)
#=> <Gecko::Record::Product id=124 name="Geckobot" product_type: "Robot">
geckobot.persisted?
#=> true
geckobot.product_type = "Robo-boogie"
geckobot.save # Persists to API
#=> true
geckobot
#=> <Gecko::Record::Product id=124 name="Geckobot" product_type: "Robo-boogie">
```


## Instrumentation

The Gecko gem supports instrumentation via AS::Notifications.
You can subscribe to API calls by subscribing to `'request.gecko'` notifications

```ruby
ActiveSupport::Notifications.subscribe('request.gecko') do |name, start, finish, id, payload|
  # Do Something
end
```

## TODO
- Saving records
- Complete record collection
- Handle API Errors
- Clean up Access Token management

## Contributing

1. Fork it ( http://github.com/[my-github-username]/gecko/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
