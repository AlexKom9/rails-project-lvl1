# frozen_string_literal: true

module HexletCode
  private_constant :Tag
  class Tag
    class << self
      def build(type, params = {})
        if block_given?
          "<#{type}#{prams_to_attr params}>#{yield}</#{type}>"
        else
          "<#{type}#{prams_to_attr params}/>"
        end
      end

      private

      def prams_to_attr(params)
        params.reduce('') { |accum, (key, value)| accum + " #{key}='#{value}'" }
      end
    end
  end
end
