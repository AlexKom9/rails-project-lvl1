# frozen_string_literal: true

module HexletCode
  module FormTags
    class Textarea < Base
      def build(name:, value:, id:, **options)
        add_tag do
          Tag.build('label', { for: id }) { name }
        end

        add_tag do
          Tag.build('textarea', { name: name, id: id, **options }) { value }
        end
      end
    end
  end
end
