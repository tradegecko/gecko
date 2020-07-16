# frozen_string_literal: true

require 'gecko'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'vcr'
require 'webmock/minitest'
require 'timecop'

require 'support/let'
require 'support/shared_adapter_examples'
require 'support/shared_record_examples'
require 'support/shared_sideloaded_data_parsing_examples'
require 'support/testing_adapter'
require 'support/vcr_support'

ENV_SECRETS = %w[
  OAUTH_ID
  OAUTH_SECRET
  ACCESS_TOKEN
  REFRESH_TOKEN
].freeze

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
  ENV_SECRETS.each do |variable|
    c.filter_sensitive_data("<__#{variable}__>") { ENV[variable] }
  end
end

class Minitest::Test
  extend Minitest::Let
end
