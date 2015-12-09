require 'active_support/inflector'
class Generate < Thor
  include Thor::Actions

  desc "model MODEL_NAME", "generates a new model"
  def model(model_name)
    @model_name = model_name
    @file_name  = model_name.underscore
    @plural     = ask "What is the underscore plural of #{@model_name}? (#{@file_name}s):"
    @plural     = @plural.to_s.length > 0 ? @plural : @file_name + "s"
    create_file "lib/gecko/record/#{@file_name}.rb", model_template
    create_file "test/record/#{@file_name}_adapter_test.rb", test_adapter_template
    create_file "test/record/#{@file_name}_test.rb", test_template
    insert_into_file("lib/gecko/client.rb", "    record :#{@model_name}\n", before: "\n    # Return OAuth client")
    append_to_file("lib/gecko.rb", "require 'gecko/record/#{@file_name}'")
  end

private
  def default_plural?
    @plural == @file_name + "s"
  end

  def model_template
%{require 'gecko/record/base'

module Gecko
  module Record
    class #{@model_name} < Base
      # belongs_to :widget
      # has_many :wodgets
      # attribute :name, String
    end

    class #{@model_name}Adapter < BaseAdapter
      #{"def plural_name
        '#{@plural}'
      end" if !default_plural?}
    end
  end
end
}
  end

  def test_template
%{require 'test_helper'

class Gecko::#{@model_name}Test < Minitest::Test
  include VCRHelper
  include SharedRecordExamples

  let(:plural_name)   { "#{@plural}" }
  let(:record_class)  { Gecko::Record::#{@model_name} }

  def setup
    @json   = load_vcr_hash("#{@plural}", "#{@plural}").first
    @record = record_class.new(client, @json)
  end

  def test_initializes_record
    assert_instance_of(Gecko::Record::#{@model_name}, @record)
  end
end
}
  end

  def test_adapter_template
%{require 'test_helper'

class Gecko::Record::#{@model_name}AdapterTest < Minitest::Test
  include TestingAdapter
  include SharedAdapterExamples

  let(:adapter)       { @client.#{@model_name} }
  let(:plural_name)   { "#{@plural}" }
  let(:record_class)  { Gecko::Record::#{@model_name} }

  def test_initializes_adapter
    assert_instance_of(Gecko::Record::#{@model_name}Adapter, @client.#{@model_name})
  end
end
}
  end
end
