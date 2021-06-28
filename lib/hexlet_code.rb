# frozen_string_literal: true

require 'byebug'
require_relative 'hexlet_code/version'
require_relative 'tag'
# require_relative 'input_tags'

module HexletCode
  class FormBuilder
    def initialize(entity)
      @entity = entity
      @temp_tegs_result = ''
    end

    def input(name, as: :input, **args)
      id = args.fetch('id', name)

      case as
      when :input
        build_input name: name, id: id, **args
      when :text
        build_textarea name: name, id: id, **args
      when :checkbox
        build_checkbox name: name, id: id, **args
      when :select
        build_select name: name, id: id, **args
      else
        # TODO: update
        raise 'Invalid as: param'
      end
    end

    def submit(text = 'Save', **args)
      add_tag do
        Tag.build 'input', { type: 'submit', **args, value: text, name: 'commit' }
      end
    end

    private

    def build_label(title, html_for, **args)
      add_tag do
        Tag.build('label', { for: html_for, **args }) { title }
      end
    end

    def add_new_line
      @temp_tegs_result += "\n"
    end

    def add_tag
      @temp_tegs_result += yield

      add_new_line
    end

    def build_input(name:, id:, **args)
      add_tag do
        Tag.build('label', { for: id }) { name }
      end

      add_tag do
        Tag.build('input', { name: :name, value: @entity[name], id: id, type: :text, **args })
      end
    end

    def build_textarea(name:, id:, **args)
      add_tag do
        Tag.build('label', { for: :id }) { name }
      end

      add_tag do
        Tag.build('textarea', { name: name, id: id, **args }) { @entity[name] }
      end
    end

    def build_select(name:, id:, **args)
      add_tag do
        Tag.build('select', { name: name, value: @entity[name], id: id }) do
          add_new_line
          result = "\n"
          args[:options].each do |option_value|
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

    def build_checkbox(name:, id:, **args)
      add_tag do
        Tag.build('input', { name: name, checked: @entity[name], value: name, id: id, **args, type: :checkbox })
      end
      add_tag do
        Tag.build('label', { for: id }) { name }
      end
    end

    def radio; end
  end

  class << self
    def form_for(entity, url = '#', method = 'post')
      Tag.build 'form', { action: url, method: method } do
        yield FormBuilder.new entity if block_given?
      end
    end
  end
end

user_struct = Struct.new(:name, :job, :citizen, :gender, keyword_init: true)
user = user_struct.new(name: 'john doe', job: 'hexlet', gender: 'f', citizen: true, )

form = HexletCode.form_for user do |f|
  f.input :name
  f.input :citizen, as: :checkbox
  f.input :gender, as: :select, options: %w[f m]
  f.submit
end

pp form