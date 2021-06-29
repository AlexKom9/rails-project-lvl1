# frozen_string_literal: true

# require 'byebug'
require_relative 'hexlet_code/version'
require_relative 'tag'

module HexletCode
  class FormBuilder
    def initialize(entity)
      @entity = entity
      @temp_tegs_result = ''
    end

    def input(name, **options)
      id = options.fetch(:id, name)
      as = options.fetch(:as, :input)

      prepared_options = options.clone
      prepared_options.delete(:id)
      prepared_options.delete(:as)

      case as
      when :input
        build_input name: name, id: id, **prepared_options
      when :text
        build_textarea name: name, id: id, **prepared_options
      when :checkbox
        build_checkbox name: name, id: id, **prepared_options
      when :select
        build_select name: name, id: id, **prepared_options
      else
        raise 'Invalid options.as'
      end
    end

    def submit(text = 'Save', **options)
      add_tag do
        Tag.build 'input', { type: 'submit', **options, value: text, name: 'commit' }
      end
    end

    private

    def build_label(title, html_for, **options)
      add_tag do
        Tag.build('label', { for: html_for, **options }) { title }
      end
    end

    def add_new_line
      @temp_tegs_result += "\n"
    end

    def add_tag
      @temp_tegs_result += yield

      add_new_line
    end

    def build_input(name:, id:, **options)
      add_tag do
        Tag.build('label', { for: id }) { name }
      end

      add_tag do
        Tag.build('input', { name: name, value: @entity[name], id: id, type: :text, **options })
      end
    end

    def build_textarea(name:, id:, **options)
      add_tag do
        Tag.build('label', { for: id }) { name }
      end

      add_tag do
        Tag.build('textarea', { name: name, id: id, **options }) { @entity[name] }
      end
    end

    def build_select(name:, id:, **options)
      add_tag do
        Tag.build('select', { name: name, value: @entity[name], id: id }) do
          add_new_line
          result = "\n"
          options[:options].each do |option_value|
            result += Tag.build('option', { value: option_value }) do
              option_value
            end
            result += "\n"
          end
          add_new_line
          result
        end
      end
    end

    def build_checkbox(name:, id:, **options)
      add_tag do
        Tag.build('input', { name: name, checked: @entity[name], value: name, id: id, **options, type: :checkbox })
      end
      add_tag do
        Tag.build('label', { for: id }) { name }
      end
    end
  end

  class << self
    def form_for(entity, url = '#', method = 'post')
      Tag.build 'form', { action: url, method: method } do
        yield FormBuilder.new entity if block_given?
      end
    end
  end
end
