# frozen_string_literal: true

module HexletCode
  autoload :FormTags, 'hexlet_code/form_tags'

  private_constant :FormBuilderInterface

  class WrongArgumentError < ::StandardError; end

  class FormBuilderInterface
    def initialize(entity)
      @entity = entity
      @temp_tags_result = ''
    end

    def input(name, **options) # rubocop:disable Metrics/AbcSize
      params = form_tags_input_params(name, **options)

      case params[:as].to_sym
      when :input
        add_tag do
          FormTags::Input.new.build name: name, value: params[:value], id: params[:id],
                                    **params[:prepared_options]
        end
      when :text
        add_tag do
          FormTags::Textarea.new.build name: name, value: params[:value], id: params[:id],
                                       **params[:prepared_options]
        end
      when :checkbox
        add_tag do
          FormTags::Checkbox.new.build name: name, value: params[:value], id: params[:id],
                                       **params[:prepared_options]
        end
      when :select
        add_tag do
          FormTags::Select.new.build name: name, value: params[:value], id: params[:id],
                                     **params[:prepared_options]
        end
      else
        raise WrongArgumentError,
              "Invalid 'as' option. Option 'as' suports only :input, :text, :checkbox and :select values"
      end
    end

    def submit(text = "Save", **options)
      add_tag do
        FormTags::Submit.new.build text, **options
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

    def add_new_line
      @temp_tags_result += "\n"
    end

    def add_tag
      @temp_tags_result += yield
    end
  end
end
