# frozen_string_literal: true

require_relative 'hexlet_code/version'
# TODO: replace with autoload
require_relative 'hexlet_code/tag'
require_relative 'hexlet_code/form_builder'

module HexletCode
  private_constant :Tag
  private_constant :FormBuilder

  class << self
    def form_for(entity, url = '#', method = 'post')
      Tag.build 'form', { action: url, method: method } do
        "#{yield FormBuilder.new entity if block_given?}\n"
      end
    end
  end
end
