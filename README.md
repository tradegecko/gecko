# TradeGecko RubyGem ![Build Status](https://github.com/tradegecko/gecko/workflows/Ruby%20Tests/badge.svg) [![Code Climate](https://codeclimate.com/github/tradegecko/gecko.png)](https://codeclimate.com/github/tradegecko/gecko)
The official TradeGecko API RubyGem

## Introduction

This library provides a Ruby interface to publicly available (beta) API for TradeGecko.

If you are unfamiliar with the TradeGecko API, you can read the documentation located at [https://developer.tradegecko.com](https://developer.tradegecko.com)

## Installation

Add this line to your application's Gemfile:

    gem 'gecko-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gecko-ruby

## Basic Usage

```ruby
client = Gecko::Client.new(CLIENT_ID, CLIENT_SECRET)
client.access_token = existing_access_token

products = client.Product.where(q: "Gecko")
#=> [<Gecko::Record::Product id=1 name="Geckotron">, <Gecko::Record::Product id=3 name="Green Gecko">]
```

## Basic Usage Using a Privileged Access Token

```ruby
client = Gecko::Client.new(CLIENT_ID, CLIENT_SECRET)
client.authorize_from_existing(PRIVILEGED_ACCESS_TOKEN, nil, nil)

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

You can create new records by calling `build` on the appropriate adapter.

```ruby
geckobot = client.Product.build(name: "Geckobot", product_type: "Robot")
#=> <Gecko::Record::Product id=nil name="Geckobot" product_type: "Robot">
geckobot.persisted?
#=> false
```

## Persisting Records

#### Create Record

You can persist new records by calling `save`.

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

You can also create new records from inside a parent object.

```ruby
variant = product.variants.build(name: "Geckobot", sku: "ROBO")
#=> <Gecko::Record::Variant id=nil product_id=123 name="Geckobot" sku: "ROBO">
variant.persisted?
#=> false
variant.save #=> Persists to API
#=> true
variant
#=> <Gecko::Record::Variant id=125 product_id=123 name="Geckobot" sku: "ROBO">
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

#### Embedded Record Serialization

Some records support being saved inside of their parents.
A good example is creating a Sales Order and it's line items.

```ruby
order = client.Order.build(company_id: 123, shipping_address_id: 123)
order.order_line_items.build(quantity: 1, variant_id: 123, price: 10.5)
order.order_line_items.build(quantity: 2, variant_id: 124, price: 11.0)
order.save # Persists to API
#=> true
order.order_line_items
#=> [<Gecko::Record::OrderLineItem id=125 variant_id=123 quantity: 1 price: '10.5'>,
     <Gecko::Record::OrderLineItem id=126 variant_id=124 quantity: 2 price: '11.0'>]
```

This also works when adding new items to an existing order.

```ruby
order = client.Order.find(123)
order.order_line_items.build(quantity: 1, variant_id: 123, price: 10.5)
order.order_line_items.build(quantity: 2, variant_id: 124, price: 11.0)
order.save # Persists to API
#=> true
order.order_line_items
#=> [<Gecko::Record::OrderLineItem id=125 variant_id=123 quantity: 1 price: '10.5'>,
     <Gecko::Record::OrderLineItem id=126 variant_id=124 quantity: 2 price: '11.0'>]
```

N.B. Only creation of embedded objects works at this time.
Updating/Deleting embedded items must still be done by calling `save/destroy`
on each of the child objects themselves.

#### Validations

```ruby
geckobot = client.Product.find(124)
#=> <Gecko::Record::Product id=124 name="Geckobot" product_type: "Robot">
geckobot.persisted?
#=> true
geckobot.name = nil
geckobot.save # Attempts to persist to API
#=> false
geckobot.valid?
#=> false
geckobot.errors
#=> #<Gecko::Errors:0x007ff46d961810 @base=#<Gecko::Record::Base:0x007ff46d96aaa0 id: 124, name: nil>, @messages={:name=>["can't be blank"]}>
```

## Instrumentation

The Gecko gem supports instrumentation via AS::Notifications.
You can subscribe to API calls by subscribing to `'request.gecko'` notifications

```ruby
ActiveSupport::Notifications.subscribe('request.gecko') do |name, start, finish, id, payload|
  # Do Something
end
```

The gem comes with a default `LogSubscriber` that outputs API requests in an ActiveRecord style.
This is disabled by default and can be included by calling `Gecko.enable_logging`.

## Checking API limits

The Gecko gem stores a copy of the last API response per adapter.
You can use this to access headers such as cache controls or current API limit usages.

```ruby
client.Product.find(124)
client.Product.last_response.headers['X-Rate-Limit-Limit']
#=> '300'
client.Product.last_response.headers['X-Rate-Limit-Remaining']
#=> '290'
client.Product.last_response.headers['X-Rate-Limit-Reset']
#=> '1412079600'
```

## Liquid Compatibility
A compatibility shim for the Liquid templating language is distributed, but not loaded by default.
This can be enabled via `Gecko.install_liquid_shim`

## TODO
- Deleting records
- Complete record collection
- Handle more API Errors
- Clean up Access Token management

## Contributing

1. Fork it ( https://github.com/tradegecko/gecko/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
