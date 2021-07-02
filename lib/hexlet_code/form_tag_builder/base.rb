# frozen_string_literal: true

module HexletCode
  module FormTagBuilder
    class Base
      def initialize
        @temp_tags_result = ''
      end

      def build
        raise 'Need to implement in subclass'
      end

      private

      def add_new_line
        @temp_tags_result += "\n"
      end

      def add_tag
        @temp_tags_result && add_new_line

        @temp_tags_result += yield
      end
    end
  end
end
