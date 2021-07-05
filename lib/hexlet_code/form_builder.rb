# frozen_string_literal: true

require 'forwardable'
module HexletCode
  autoload :FormTags, 'hexlet_code/form_tags'

  private_constant :FormBuilder

  class WrongArgumentError < ::StandardError; end

  class FormBuilder
    extend Forwardable

    def initialize(entity)
      @submit = FormTags::Submit.new

      @entity = entity
      @temp_tags_result = ''
    end

    def input(name, **options)
      params = form_tags_input_params(name, **options)
      add_tag do
        resolve_tag(params[:as]).new.build name: name, value: params[:value], id: params[:id],
                                           **params[:prepared_options]
      end
    end

    def submit(name = 'Save', **params)
      add_tag do
        FormTags::Submit.new.build name, **params
      end
    end

    private

    def form_tags_input_params(name, **options)
      id = options.fetch(:id, name)
      as = options.fetch(:as, :input)

      prepared_options = options.clone
      prepared_options.delete(:id)
      prepared_options.delete(:as)

      { as: as, value: @entity[name], id: id, prepared_options: prepared_options }
    end

    def resolve_tag(as_tag)
      case as_tag.to_sym
      when :input
        FormTags::Input
      when :text
        FormTags::Textarea
      when :checkbox
        FormTags::Checkbox
      when :select
        FormTags::Select
      else
        raise WrongArgumentError,
              "Invalid 'as' option. Option 'as' suports only :input, :text, :checkbox and :select values"
      end
    end

    def add_new_line
      @temp_tags_result += "\n"
    end

    def add_tag
      @temp_tags_result += yield
    end
  end
end
