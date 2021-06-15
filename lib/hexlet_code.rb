# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  module Tag
    class Error < StandardError; end
  
    class << self
      def build type, params = {}, &block
        if block_given?
          "<#{type} #{prams_to_attr params}>#{ yield }</#{type}>"
        else
          "<#{type} #{prams_to_attr params}/>"
        end
      end
  
      private
  
      def prams_to_attr params
        params.reduce("") { |accum, (key, value)| accum += " #{key}='#{value}'" }
      end
    end
  end
  
end