Unreleased
-----
* Gecko::Client wraps around TradeGecko Authentication
* Defines the framework for Gecko::Record::XXXX record classes
* Add `belongs_to`/`has_many` support to `Gecko::Record` types
* Adds `@client.Record` record adapter accessors
* Basic query methods for Records `client.Record.find(1)`, `client.Record.where()`
* Adds a basic IdentityMap and related query methods
* Custom record#inspect
* Add `Gecko::Record::Account`
* Add current account query method `@client.Account.current`
* Custom `RecordNotFound` errors
* Verify and ID is passed to the find methods
* Add `rake console`
* Add basic serialization via `serializable_hash` and `as_json` methods to records
* Add support for readonly attributes to record definitions
