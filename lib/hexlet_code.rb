# frozen_string_literal: true

require_relative 'hexlet_code/version'
module HexletCode
  autoload :Tag, 'hexlet_code/tag'
  autoload :FormBuilderInterface, 'hexlet_code/form_builder_interface'

  private_constant :Tag
  private_constant :FormBuilderInterface

  class << self
    def form_for(entity, url = '#', method = 'post')
      Tag.build 'form', { action: url, method: method } do
        "#{yield FormBuilderInterface.new entity if block_given?}\n"
      end
    end
  end
end
