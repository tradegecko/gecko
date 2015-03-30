require 'gecko'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/mini_test'
require 'vcr'
require 'webmock/minitest'
require 'timecop'

require 'support/let'
require 'support/shared_adapter_examples'
require 'support/shared_record_examples'
require 'support/shared_sideloaded_data_parsing_examples'
require 'support/testing_adapter'
require 'support/vcr_support'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

class Minitest::Test
  extend Minitest::Let
end
