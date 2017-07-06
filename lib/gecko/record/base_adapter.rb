module Gecko
  module Record
    class BaseAdapter
      attr_reader :client, :last_response
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
        @identity_map = {}
      end

      # Find a record via ID, first searches the Identity Map, then makes an
      # API request.
      #
      # @example
      #   client.Product.find(12)
      #
      # @param [Integer] id ID of record
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
      # @param [Array<Integer>] ids IDs of records to fetch
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

      # Fetch a record collection via the API. Parameters vary via Record Type
      #
      # @example Fetch via ID
      #   client.Product.where(ids: [1,2])
      #
      # @example Fetch via date
      #   client.Product.where(updated_at_min: "2014-03-03T21:09:00")
      #
      # @example Search
      #   client.Product.where(q: "gecko")
      #
      # @param [#to_hash] params
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
        response = @last_response = request(:get, plural_path, params: params)
        parsed_response = response.parsed
        set_pagination(response.headers)
        parse_records(parsed_response)
      end

      # Returns all the records currently in the identity map.
      #
      # @example Return all Products previously fetched
      #   client.Product.peek_all
      #
      # @return [Array<Gecko::Record::Base>]
      #
      # @api public
      def peek_all
        @identity_map.values
      end

      # Fetch the first record for the given parameters
      #
      # @example Fetch via ID
      #   client.Product.first
      #
      # @example Fetch via date
      #   client.Product.first(updated_at_min: "2014-03-03T21:09:00")
      #
      # @example Search
      #   client.Product.first(q: "gecko")
      #
      # @param [#to_hash] params
      # @option params [String] :q Search query
      # @option params [Array<Integer>] :ids IDs to search for
      # @option params [String] :updated_at_min Last updated_at minimum
      # @option params [String] :updated_at_max Last updated_at maximum
      # @option params [String] :order Sort order i.e 'name asc'
      # @option params [String, Array<String>] :status Record status/es
      #
      # @return <Gecko::Record::Base> A record instance
      #
      # @api public
      def first(params={})
        where(params.merge(limit: 1)).first
      end

      # Fetch the forty-second record for the given parameters
      #
      # @api public
      def forty_two(params={})
        where(params.merge(limit: 1, page: 42)).first
      end

      # Returns the total count for a record type via API request.
      #
      # @example
      #   client.Product.count
      #
      # @param [#to_hash] params
      #
      # @return [Integer] Total number of available records
      #
      # @api public
      def count(params = {})
        self.where(params.merge(limit: 0))
        @pagination['total_records']
      end

      # Returns the total count for a record type. Reads from the last request or
      # makes a new request if not available.
      #
      # @example
      #   client.Product.size
      #
      # @return [Integer] Total number of available records
      #
      # @api public
      def size
        (defined?(@pagination) && @pagination['total_records']) || count
      end

      # Fetch a record via API, regardless of whether it is already in identity map.
      #
      # @example
      #   client.Product.fetch(12)
      #
      # @param [Integer] id ID of record
      #
      # @return [Gecko::Record::Base] if a record was found
      # @return [nil] if no record was found
      #
      # @api private
      def fetch(id)
        verify_id_presence!(id)
        response = @last_response = request(:get, plural_path + '/' + id.to_s)
        record_json = extract_record(response.parsed)
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
        parse_sideloaded_records(json)
        extract_collection(json).map do |record_json|
          instantiate_and_register_record(record_json)
        end
      end

      # Extract a collection from an API response
      #
      # @return [Hash]
      #
      # @api private
      def extract_collection(json)
        json[plural_path]
      end

      # Extract a record from an API response
      #
      # @return Hash
      #
      # @api private
      def extract_record(json)
        json && json[json_root]
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
      # @param [#to_hash] initial attributes to set up the record
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
      # @param [Hash] opts the options to make the request with
      # @option opts [Hash] :idempotency_key A unique identifier for this action
      #
      # @return [Boolean] whether the save was successful.
      #                   If false the record will contain an errors hash
      #
      # @api private
      def save(record, opts = {})
        if record.persisted?
          update_record(record, opts)
        else
          create_record(record, opts)
        end
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
        json_root + 's'
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
      def create_record(record, opts = {})
        response = request(:post, plural_path, {
          body: record.as_json,
          raise_errors: false
        }.merge(headers: headers_from_opts(opts)))
        handle_response(record, response)
      end

      # Update a record via API
      #
      # @return [OAuth2::Response]
      #
      # @api private
      def update_record(record, opts = {})
        response = request(:put, plural_path + "/" + record.id.to_s, {
          body: record.as_json,
          raise_errors: false
        }.merge(headers: headers_from_opts(opts)))
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
          if response_json = extract_record(response.parsed)
            record.attributes = response_json
            register_record(record)
          end
          true
        when 422
          record.errors.from_response(response.parsed['errors'])
          false
        else
          fail OAuth2::Error.new(response)
        end
      end

      # Sets up the pagination metadata on a record adapter
      #
      # @api private
      def set_pagination(headers)
        @pagination = JSON.parse(headers["x-pagination"]) if headers["x-pagination"]
      end

      # Applies an idempotency key to the request if provided
      #
      # @api private
      def headers_from_opts(opts)
        headers = {}
        headers['Idempotency-Key'] = opts[:idempotency_key] if opts[:idempotency_key]
        headers
      end

      # Parse and instantiate sideloaded records
      #
      # @api private
      def parse_sideloaded_records(json)
        json.each do |record_type, records|
          next if record_type == "meta"
          next if record_type == @model_name.to_s

          record_class = record_type.singularize.classify
          next unless Gecko::Record.const_defined?(record_class)
          adapter = @client.adapter_for(record_class)

          records.each do |record_json|
            adapter.instantiate_and_register_record(record_json)
          end
        end
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
        ActiveSupport::Notifications.instrument('request.gecko') do |payload|
          payload[:verb]         = verb
          payload[:params]       = options[:params]
          payload[:body]         = options[:body]
          payload[:model_class]  = model_class
          payload[:request_path] = path
          options[:headers]      = options.fetch(:headers, {}).tap { |headers| headers['Content-Type'] = 'application/json' }
          options[:body]         = options[:body].to_json if options[:body]
          payload[:response]     = @client.access_token.request(verb, path, options)
        end
      end

      def record_not_found!(id)
        fail RecordNotFound, "Couldn't find #{model_class.name} with id=#{id}"
      end

      def record_not_in_identity_map!(id)
        fail RecordNotInIdentityMap, "Couldn't find #{model_class.name} with id=#{id}"
      end

      def verify_id_presence!(id)
        if id.respond_to?(:empty?) ? id.empty? : !id
          fail RecordNotFound, "Couldn't find #{model_class.name} without an ID"
        end
      end
    end
  end
end
