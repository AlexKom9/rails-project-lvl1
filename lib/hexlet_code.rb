# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'tag'
require_relative 'form_builder'

module HexletCode
  private_constant :Tag
  private_constant :FormBuilder

  class << self
    def form_for(entity, url = '#', method = 'post')
      Tag.build 'form', { action: url, method: method } do
        yield FormBuilder.new entity if block_given?
      end
    end
  end
end
