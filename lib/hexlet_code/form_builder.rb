# frozen_string_literal: true

require 'byebug'

require_relative './form_tag_builder'

module HexletCode
  private_constant :FormTagBuilder

  class FormBuilder
    def initialize(entity)
      @entity = entity
      @temp_tags_result = ''
    end

    def input(name, **options)
      id = options.fetch(:id, name)
      as = options.fetch(:as, :input)

      prepared_options = options.clone
      prepared_options.delete(:id)
      prepared_options.delete(:as)

      case as.to_sym
      when :input
        add_tag do
          FormTagBuilder::Input.new.build name: name, value: @entity[name], id: id, **prepared_options
        end
      when :text
        add_tag do
          FormTagBuilder::Textarea.new.build name: name, value: @entity[name], id: id, **prepared_options
        end
      when :checkbox
        add_tag do
          FormTagBuilder::Checkbox.new.build name: name, value: @entity[name], id: id, **prepared_options
        end
      when :select
        add_tag do
          FormTagBuilder::Select.new.build name: name, value: @entity[name], id: id, **prepared_options
        end
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

    def add_new_line
      @temp_tags_result += "\n"
    end

    def add_tag
      @temp_tags_result += yield
    end
  end
end
