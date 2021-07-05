# frozen_string_literal: true

module HexletCode
  module FormTagBuilder
    class Input < Base
      def build(name:, value:, id:, **options)
        add_tag do
          Tag.build('label', { for: id }) { name }
        end
        add_tag do
          Tag.build('input', { name: name, value: value, id: id, type: :text, **options })
        end
      end
    end
  end
end
