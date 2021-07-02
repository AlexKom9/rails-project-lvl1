# frozen_string_literal: true

module HexletCode
  # autoload :FormTagBuilderBase, './form_tag_builder_base'
  module FormTagBuilder
    class Checkbox < Base
      def build(name:, value:, id:, **options)
        add_tag do
          Tag.build('input', { name: name, checked: value, value: name, id: id, **options, type: :checkbox })
        end
        
        add_tag do
          Tag.build('label', { for: id }) { name }
        end
      end
    end
  end
end
