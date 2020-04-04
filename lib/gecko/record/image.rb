# frozen_string_literal: true

require 'gecko/record/base'

module Gecko
  module Record
    class Image < Base
      AVAILABLE_SIZES = %i[full thumbnail].freeze

      belongs_to :variant
      belongs_to :uploader, class_name: "User",   readonly: true
      attribute :name,             String
      attribute :url,              String
      attribute :position,         Integer,       readonly: true
      attribute :base_path,        String,        readonly: true
      attribute :file_name,        String,        readonly: true
      attribute :versions,         Array[String], readonly: true

      # attribute :image_processing, Boolean

      # URL for image
      #
      # @param [Symbol] :size (:full) The image size, currently only :full,
      #  :medium and :thumbnail supported
      #
      # @return [String]
      #
      # @api public
      def url(size = :full)
        super() || build_url(size)
      end

    private

      def build_url(size)
        file_path = if size == :full
                      file_name
                    else
                      "#{size}_#{file_name}"
                    end
        [base_path, file_path].join("/")
      end
    end

    class ImageAdapter < BaseAdapter
    private

      def update_record(_record)
        raise NotImplementedError
      end
    end
  end
end
