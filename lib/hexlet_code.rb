# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  module Tag
    class Error < StandardError; end
  
    class << self
      # TODO: ann block
      def build type, params = {}
        send(type, params)
      end

      def br params 
        p 'br' 
      end
  
      def img params
        p 'img'
      end
  
      def input params
        p 'input'  
      end
  
      def label params
        p 'label'
      end
    end
  end
end


HexletCode::Tag.build("br")
