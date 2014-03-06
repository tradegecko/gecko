## Unreleased

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
