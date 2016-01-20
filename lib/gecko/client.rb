require 'faraday'
require 'oauth2/version'
require 'gecko/version'
require 'gecko/helpers/record_helper'

module Gecko
  # The Gecko::Client class
  class Client
    extend Helpers::RecordHelper

    record :Account
    record :Currency
    record :Location
    record :User

    record :Address
    record :Company
    record :Contact

    record :Order
    record :OrderLineItem
    record :Fulfillment
    record :FulfillmentLineItem
    record :Invoice
    record :InvoiceLineItem

    record :Product
    record :Variant
    record :Image
    record :PurchaseOrder
    record :PurchaseOrderLineItem
    record :TaxType
    record :PaymentTerm
    record :PaymentMethod

    # Return OAuth client
    #
    # @return [OAuth2::Client]
    #
    # @api private
    attr_reader :oauth_client

    # Access the OAuth AccessToken for this client
    #
    # @return [OAuth2::AccessToken]
    #
    # @api public
    attr_accessor :access_token

    # Initialize a new Gecko client object with an instantiated OAuth2::Client
    #
    # @param [String] client_id
    # @param [String] client_secret
    # @param [#to_hash] extra options hash to pass to the OAuth2::Client
    #
    # @return [undefined]
    #
    # @api private
    def initialize(client_id, client_secret, options={})
      setup_oauth_client(client_id, client_secret, options)
    end

    # Authorize client from existing access and refresh token
    #
    # @example
    #   client.authorize_from_existing("ABC", "DEF", "1393982563")
    #
    # @param [String] access_token
    # @param [String] refresh_token
    # @param [String] expires_at
    #
    # @return [OAuth2::AccessToken]
    #
    # @api public
    def authorize_from_existing(access_token, refresh_token, expires_at)
      @access_token = OAuth2::AccessToken.new(oauth_client, access_token, {
        refresh_token: refresh_token,
        expires_at:    expires_at
      })
    end

    # Authorize client by fetching a new access_token via refresh token
    #
    # @example
    #   client.authorize_from_refresh_token("DEF")
    #
    # @param [String] refresh_token
    #
    # @return [OAuth2::AccessToken]
    #
    # @api public
    def authorize_from_refresh_token(refresh_token)
      @access_token = oauth_client.get_token({
        client_id:     oauth_client.id,
        client_secret: oauth_client.secret,
        refresh_token: refresh_token,
        grant_type:    'refresh_token'
      })
    end

    # Fetch the adapter for a specified Gecko::Record class
    #
    # @param [String] klass_name Gecko::Record subclass name
    #
    # @return [Gecko::Record::BaseAdapter]
    #
    # @api private
    def adapter_for(klass_name)
      self.public_send(klass_name.to_sym)
    end

  private

    def setup_oauth_client(client_id, client_secret, options)
      defaults = {
        site:          'https://api.tradegecko.com',
        authorize_url: 'https://go.tradegecko.com/oauth/authorize',
        connection_opts: {
          headers:     self.class.default_headers
        }
      }
      @oauth_client = OAuth2::Client.new(client_id, client_secret, defaults.merge(options))
    end

    def self.default_headers
      {
        'User-Agent' => ["Gecko/#{Gecko::VERSION}",
                         "OAuth2/#{OAuth2::Version.to_s}",
                         "Faraday/#{Faraday::VERSION}",
                         "Ruby/#{RUBY_VERSION}"].join(' ')
      }
    end
  end
end
