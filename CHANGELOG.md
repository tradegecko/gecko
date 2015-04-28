## 0.0.8 (2015-04-28)
- Fetch VariantLocation#committed_stock as committed

## 0.0.7 (2015-03-17)
- Fix issue with Order#tax_override
- Support sideloaded records without a hack

## 0.0.6 (2015-03-17)
- Add `Gecko::Record::PaymentTerm`

## 0.0.5 (2015-03-04)
- Add size to base adapter
- Update serialization_helper to support serializing arrays correctly

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
