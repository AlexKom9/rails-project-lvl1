# frozen_string_literal: true

module HexletCode
  module FormTagBuilder
    class Submit < Base
      def build(text = 'Save', **options)
        Tag.build 'input', { type: 'submit', name: 'commit', **options, value: text }
      end
    end
  end
end
