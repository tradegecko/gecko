module Gecko
  module Record
    # Generic Gecko::Record exception class.
    class BaseError < StandardError
    end

    # Raise when a record can not be found via API
    class RecordNotFound < BaseError
    end

    # Raised when a record can not be found in the Identity Map
    class RecordNotInIdentityMap < BaseError
    end
  end
end
