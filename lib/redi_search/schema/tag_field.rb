# frozen_string_literal: true

require "active_record/type"

module RediSearch
  class Schema
    class TagField
      def initialize(name, separator: nil, sortable: false, no_index: false)
        @name = name
        @separator = separator
        @sortable = sortable
        @no_index = no_index
      end

      def to_a
        query = [name.to_s, "TAG"]
        query += boolean_options_string
        query += ["SEPARATOR", separator] if separator

        query
      end

      private

      attr_reader :name, :separator, :sortable, :no_index

      def boolean_options_string
        %i(sortable no_index).map do |option|
          if ActiveRecord::Type::Boolean.new.cast(send(option))
            option.to_s.upcase.split("_").join
          end
        end.compact
      end
    end
  end
end
