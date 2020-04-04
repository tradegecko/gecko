# frozen_string_literal: true

require 'request_store'

# Requiring this file, or calling `Gecko.enable_logging` will hook into the provided
# ActiveSupport::Notification hooks on requests and log ActiveRecord-style messages
# on API requests.
class GeckoLogSubscriber < ActiveSupport::LogSubscriber
  ENV_KEY = :"gecko-logger"

  def initialize
    super
    @odd = false
  end

  def request(event) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    RequestStore.store[ENV_KEY] = []
    payload = event.payload

    request_path = payload[:request_path]

    if payload[:params] && payload[:verb] == :get
      request_path = request_path + "?" + payload[:params].to_param
      RequestStore.store[ENV_KEY] << request_path
    end

    name  = "#{payload[:model_class]} Load (#{event.duration.round(1)}ms)"
    query = "#{payload[:verb].to_s.upcase} /#{request_path}"

    name = if odd?
             color(name, CYAN, true)
           else
             color(name, MAGENTA, true)
           end

    query = color(query, nil, true)

    debug("  #{name}  #{query}")
  end

  def odd?
    @odd = !@odd
  end
end

GeckoLogSubscriber.attach_to :gecko
