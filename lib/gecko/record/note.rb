# frozen_string_literal: true

require 'gecko/record/base'

module Gecko
  module Record
    class Note < Base
      belongs_to :company
      belongs_to :user

      attribute :body,  String
    end

    class NoteAdapter < BaseAdapter
    end
  end
end
