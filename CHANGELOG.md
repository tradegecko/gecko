## 0.12.3 (Unreleased)
- Add `issued_at` to `Gecko::Record::PurchaseOrder`

## 0.12.2 (2020-08-12)
- Change authorize url to commerce.intuit.com
- Add `payment_due_at` to `Gecko::Record::PurchaseOrder`

## 0.12.1 (2020-07-20)
- Add `Gecko::Record::PaymentMethod` model.

## 0.12.0 (2020-07-09)
- Silence warnings in Ruby 2.7
- Ensure response is passed to `ActiveSupport::Notifications` on error
- Ensure `adapter.last_response` is set on error response

## 0.11.1 (2020-04-30)
- Fix addresses on Invoice

## 0.11.0 (2020-04-29)
- Store create/update responses under `adapter.last_response` as well.

## 0.10.0 (2020-04-06)
- Add extra delegated attributes to invoice record
- [BREAKING] Update Image record to latest API with product and multiple variant support

## 0.9.1 (2019-07-29)
- Fix issue with LiquidCompat that broke during refactor

## 0.9.0 (2019-07-24)
- Added an optional `ActiveSupport::LogSubscriber` class for easy logging,
  can be enabled via `Gecko.enable_logging`.
- Added an optional compatibility shim for the Liquid templating language,
  can be enabled via `Gecko.install_liquid_shim`.

## 0.8.0 (2019-07-01)
- Add `discount_amount` attribute and `discounted_price` helper to `OrderLineItem`'s.
- Drop support for EOL Ruby 2.3 as well.

## 0.7.1 (2019-03-19)
- Add `Gecko::Record::Note` model.
- Fix issue with `find_many` which manifested as a bug in `has_many` definitions with cached records being duplicated when more than 100 children existed.

## 0.7.0 (2019-02-19)
- Add new `country_code` attribute to Address model.
- Stop testing on Ruby 2.1 and 2.2.

## 0.6.0 (2018-11-13)
- Add `Gecko::Record::Webhook` model.
- Expose new `available` attribute on a Variant#VariantLocation model, this should remove the need to calculate available stock on the client.

## 0.5.0 (2018-08-15)
- [BREAKING CHANGE] has_many associations now return an enumerable
  `CollectionProxy` where they used to return a plain array.
- `has_many` associations now support `.build` which automatically assigns the parent
  relation. `item = order.order_line_items.build(quantity: 123, variant_id: 123, price: 123)`
  `item.order == order`.
- Support for embedded serialization.
  i.e `order.order_line_items.build(quantity: 123, price: 123, variant_id: 123); order.save`
  will now save the Order and the order line items in a single API request.
- Add minimum `oauth2` gem dependency

## 0.2.5 (2018-01-15)
- Add `User#account_name`.

## 0.2.4 (2017-08-28)
- Add `Company#tags`.

## 0.2.3 (2017-08-14)
- Add support for API idempotency `@client.Record.save(idempotency_key: 'ABCDEF123456')`.
- Marked a couple of fields as readonly that weren't correctly marked so.

## 0.2.2 (2016-06-06)
- Add `@client.Record.peek_all` to return all items currently in identity map.

## 0.2.1 (2016-06-06) (Yanked)
## 0.2.0 (2016-06-06)
- Support `writeable_on :create` for attributes.
- Allow passing query parameters to `Adapter#count`.
- Add `@client.Record.first` and `@client.Record.forty_two` as helpers.
- Store the last API response at `@client.Record.last_response`.
- Make sure to set Content-Type to `application/json`.
- Clean up some deprecated fields leading up to API release (See [https://developer.tradegecko.com](https://developer.tradegecko.com) for up-to-date attribute list).

## 0.1.0 (2015-11-25)
- Move default headers to the adapter base class to make it easier to merge them when overriding.
- Clean up old attributes.

## 0.0.10 (2015-10-21)
- Add `first_name`/`last_name` to addresses.

## 0.0.9 (2015-10-02)
- Add tags to order.

## 0.0.8 (2015-09-10)
- Fetch `VariantLocation#committed_stock` as committed.
- Make image uploading work.

## 0.0.7 (2015-03-17)
- Fix issue with `Order#tax_override`.
- Support sideloaded records without a hack.

## 0.0.6 (2015-03-17)
- Add `Gecko::Record::PaymentTerm`.

## 0.0.5 (2015-03-04)
- Add `size` to base adapter.
- Update serialization_helper to support serializing arrays correctly.

## 0.0.4 (2015-01-09)
- Renamed gem so we can publish it on RubyGems.org
- Add `Gecko::Record::TaxType`
- Add `Gecko::Record::PurchaseOrder` and `Gecko::Record::PurchaseOrderLineItem`
- Add `Gecko::Record::Invoice` & `Gecko::Record::InvoiceLineItem`
- Change pagination numbers to fetch from the headers instead of the metadata object
- Add `Gecko::Record::Contact`
- Add `Gecko::Record::User`
- Add `Gecko::Record::Location`
- Remove `@client.Account.build`
- TradeGecko API updates - Variant prices + locations now returned as arrays

## 0.0.3 (2014-03-27)

- Add `record.save`
- Parse server-side validation errors
- Add support for readonly attributes in serialization
- Basic serialization support via `as_json` and `serializable_hash` helpers

## 0.0.2 (2014-03-08)

- AS::Notifications for API calls
- Add `@client.Record.build(attributes)`
- Add `Record#persisted?`
- Implement a custom User-Agent

## 0.0.1 (2014-03-07)

- Add `rake console`
- Verify an ID is passed to the find methods
- Custom `RecordNotFound` errors
- Add current account query method `@client.Account.current`
- Add `Gecko::Record::Account`
- Custom `record#inspect`
- Adds a basic IdentityMap and related query methods
- Basic query methods for Records `client.Record.find(1)`, `client.Record.where()`
- Adds `@client.Record` record adapter accessors
- Add `belongs_to`/`has_many` support to `Gecko::Record` types
- Defines the framework for Gecko::Record::XXXX record classes
- Gecko::Client wraps around TradeGecko Authentication
