# frozen_string_literal: true

require 'test_helper'

class Gecko::WebhookTest < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "webhooks" }
  let(:record_class)  { Gecko::Record::Webhook }

  def setup
    @json   = load_vcr_hash("webhooks", "webhooks").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::Webhook, @record)
  end
end
