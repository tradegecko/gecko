require 'gecko/record/base'

module Gecko
  module Record
    class EmailTemplate < Base
      attribute :body,        String
      attribute :mailer_name, String
      attribute :name,        String
      attribute :subject,     String
    end

    class EmailTemplateAdapter < BaseAdapter
    end
  end
end
