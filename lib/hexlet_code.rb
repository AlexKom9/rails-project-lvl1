# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'tag'

module HexletCode
  class FormBuilder
    def initialize(entity)
      @entity = entity
      @temp_tegs_result = ''
    end

    # rubocop:disable Naming/MethodParameterName
    def input(field_name, as: :input, type: 'text', **args)
      tag_name = as == :text ? 'textarea' : 'input'

      id = args.fetch('id', field_name)

      build_label field_name, id
      build_input field_name, tag_name, **args, id: id, type: type
    end
    # rubocop:enable Naming/MethodParameterName

    def submit(text = 'Save', **args)
      add_tag do
        Tag.build 'input', { type: 'submit', **args, value: text, name: 'commit' }
      end
    end

    private

    def build_input(field_name, tag_name, **args)
      if tag_name == 'textarea'
        add_tag do
          Tag.build(tag_name, { name: field_name, **args }) { @entity[field_name] }
        end
      else
        add_tag { Tag.build(tag_name, { name: field_name, value: @entity[field_name], **args }) }
      end
    end

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
  end

  class << self
    def form_for(entity, url = '#', method = 'post')
      Tag.build 'form', { action: url, method: method } do
        yield FormBuilder.new entity if block_given?
      end
    end
  end
end
