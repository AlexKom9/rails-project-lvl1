# frozen_string_literal: true

module HexletCode
  module FormTagBuilder
    class Select < Base
      def build(name:, value:, id:, **options)
        add_tag do
          Tag.build('label', { for: id }) { name }
        end

        add_tag do
          Tag.build('select', { name: name, value: value, id: id }) do
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
    end
  end
end
