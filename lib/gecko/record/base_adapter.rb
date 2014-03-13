module Gecko
  module Record
    class BaseAdapter
      attr_reader :client
      # Instantiates a new Record Adapter
      #
      # @param [Gecko::Client] client
      # @param [String] model_name
      #
      # @return [undefined]
      #
      # @api private
      def initialize(client, model_name)
        @client       = client
        @model_name   = model_name
        @identity_map = Hash.new
      end

      # Find a record via ID, first searches the Identity Map, then makes an
      # API request.
      #
      # @example
      #   client.Product.find(12)
      #
      # @params [Integer] id ID of record
      #
      # @return [Gecko::Record::Base] if a record was found
      #   either in the identity map or via the API
      # @return [nil] If no record was found
      #
      # @api public
      def find(id)
        if has_record_for_id?(id)
          record_for_id(id)
        else
          fetch(id)
        end
      end

      # Searches the Identity Map for a record via ID
      #
      # @example
      #   client.Product.record_for_id(12)
      #
      # @return [Gecko::Record::Base] if a record was found in the identity map.
      # @raise  [Gecko::Record::RecordNotInIdentityMap] If no record was found
      #
      # @api private
      def record_for_id(id)
        verify_id_presence!(id)
        @identity_map.fetch(id) { record_not_in_identity_map!(id) }
      end

      # Returns whether the Identity Map has a record for a particular ID
      #
      # @example
      #   client.Product.has_record_for_id?(12)
      #
      # @return [Boolean] if a record was found in the identity map.
      #
      # @api private
      def has_record_for_id?(id)
        @identity_map.key?(id)
      end

      # Find multiple records via IDs, searching the Identity Map, then making an
      # API request for remaining records. May return nulls
      #
      # @example
      #   client.Product.find_many([12, 13, 14])
      #
      # @params [Array<Integer>] ids IDs of record
      #
      # @return [Array<Gecko::Record::Base>] Records for the ids
      #   either in the identity map or via the API
      #
      # @api public
      def find_many(ids)
        existing, required = ids.partition { |id| has_record_for_id?(id) }
        if required.any?
          where(ids: ids) + existing.map { |id| record_for_id(id) }
        else
          existing.map { |id| record_for_id(id) }
        end
      end

      # Make an API request with parameters. Parameters vary via Record Type
      #
      # @example Fetch via ID
      #   client.Product.where(ids: [1,2]
      #
      # @example Fetch via date
      #   client.Product.where(updated_at_min: "2014-03-03T21:09:00")
      #
      # @example Search
      #   client.Product.where(q: "gecko")
      #
      # @params [#to_hash] params
      # @option params [String] :q Search query
      # @option params [Integer] :page (1) Page number for pagination
      # @option params [Integer] :limit (100) Page limit for pagination
      # @option params [Array<Integer>] :ids IDs to search for
      # @option params [String] :updated_at_min Last updated_at minimum
      # @option params [String] :updated_at_max Last updated_at maximum
      # @option params [String] :order Sort order i.e 'name asc'
      # @option params [String, Array<String>] :status Record status/es
      #
      # @return [Array<Gecko::Record::Base>] Records via the API
      #
      # @api public
      def where(params={})
        response        = request(:get, plural_path, params: params)
        parsed_response = response.parsed
        set_metadata(parsed_response)
        parse_records(parsed_response)
      end

      # Return total count for a record type. Fetched from the metadata
      #
      # @example
      #   client.Product.count
      #
      # @return [Integer] Total record count
      #
      # @api public
      def count
        self.where(limit: 0)
        @metadata["total"]
      end

      # Fetch a record via API, regardless of whether it is already in identity map.
      #
      # @example
      #   client.Product.fetch(12)
      #
      # @return [Gecko::Record::Base] if a record was found
      # @return [nil] if no record was found
      #
      # @api private
      def fetch(id)
        verify_id_presence!(id)
        response    = request(:get, plural_path + "/" + id.to_s)
        record_json = response.parsed[json_root]
        instantiate_and_register_record(record_json)
      rescue OAuth2::Error => ex
        case ex.response.status
        when 404
          record_not_found!(id)
        else
          raise
        end
      end

      # Parse a json collection and instantiate records
      #
      # @return [Array<Gecko::Record::Base>]
      #
      # @api private
      def parse_records(json)
        json[plural_path].map do |record_json|
          instantiate_and_register_record(record_json)
        end
      end

      # Build a new record
      #
      # @example
      #   new_order = client.Order.build(company_id: 123, order_number: 1234)
      #
      # @example
      #   new_order = client.Order.build
      #   new_order.order_number = 1234
      #
      # @params [#to_hash] attributes
      #
      # @return [Gecko::Record::Base]
      #
      # @api public
      def build(attributes={})
        model_class.new(@client, attributes)
      end

      # Save a record
      #
      # @params [Object] :record A Gecko::Record object
      #
      # @return [Boolean] whether the save was successful.
      #                   If false the record will contain an errors hash
      #
      # @api private
      def save(record)
        if record.persisted?
          update_record(record)
        else
          create_record(record)
        end
      end
    private
      # Returns the json key for a record adapter
      #
      # @example
      #   product_adapter.json_root #=> "product"
      #
      # @return [String]
      #
      # @api private
      def json_root
        @model_name.to_s.underscore
      end

      # Returns the pluralized name of a record class used for generating API endpoint
      #
      # @return [String]
      #
      # @api private
      def plural_path
        json_root + "s"
      end

      # Returns the model class associated with an adapter
      #
      # @example
      #   product_adapter.model_class #=> Gecko::Record::Product
      #
      # @return [Class]
      #
      # @api private
      def model_class
        Gecko::Record.const_get(@model_name)
      end

      # Instantiates a record from it's JSON representation and registers
      # it into the identity map
      #
      # @return [Gecko::Record::Base]
      #
      # @api private
      def instantiate_and_register_record(record_json)
        record = model_class.new(@client, record_json)
        register_record(record)
        record
      end

      # Registers a record into the identity map
      #
      # @return [Gecko::Record::Base]
      #
      # @api private
      def register_record(record)
        @identity_map[record.id] = record
      end

      # Create a record via API
      #
      # @return [OAuth2::Response]
      #
      # @api private
      def create_record(record)
        response = request(:post, plural_path, {
          body: record.as_json,
          raise_errors: false
        })
        handle_response(record, response)
      end

      # Update a record via API
      #
      # @return [OAuth2::Response]
      #
      # @api private
      def update_record(record)
        response = request(:put, plural_path + "/" + record.id.to_s, {
          body: record.as_json,
          raise_errors: false
        })
        handle_response(record, response)
      end

      # Handle the API response.
      # - Updates the record if attributes are returned
      # - Adds validation errors from a 422
      #
      # @return [OAuth2::Response]
      #
      # @api private
      def handle_response(record, response)
        case response.status
        when 200..299
          if (response.parsed)
            response_json = response.parsed[json_root]
            record.attributes = response_json
            register_record(record)
          end
          true
        when 422
          record.errors.from_response(response.parsed["errors"])
          false
        else
          raise OAuth2::Error.new(response)
        end
      end

      # Sets up the metadata on a record adapter
      #
      # @api private
      def set_metadata(json)
        @metadata = json["meta"] if json["meta"]
      end

      # Makes a request to the API.
      #
      # @param [Symbol] verb the HTTP request method
      # @param [String] path the HTTP URL path of the request
      # @param [Hash] opts the options to make the request with
      # @option opts [Hash] :params params for request
      #
      # @return [OAuth2::Response]
      #
      # @api private
      def request(verb, path, options={})
        ActiveSupport::Notifications.instrument("request.gecko") do |payload|
          payload[:verb]         = verb
          payload[:params]       = options[:params]
          payload[:model_class]  = model_class
          payload[:request_path] = path
          payload[:response]     = @client.access_token.request(verb, path, options)
        end
      end

      def record_not_found!(id)
        raise RecordNotFound, "Couldn't find #{model_class.name} with id=#{id}"
      end

      def record_not_in_identity_map!(id)
        raise RecordNotInIdentityMap, "Couldn't find #{model_class.name} with id=#{id}"
      end

      def verify_id_presence!(id)
        if id.respond_to?(:empty?) ? id.empty? : !id
          raise RecordNotFound, "Couldn't find #{model_class.name} without an ID"
        end
      end
    end
  end
end
