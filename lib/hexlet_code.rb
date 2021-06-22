# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  # HTML tags builder module
  module Tag
    class Error < StandardError; end

    class << self
      def build(type, params = {})
        if block_given?
          "<#{type}#{prams_to_attr params}>\n#{yield}\n</#{type}>"
        else
          "<#{type}#{prams_to_attr params}/>"
        end
      end

      private

      def prams_to_attr(params)
        params.reduce("") { |accum, (key, value)| accum + " #{key}='#{value}'" }
      end
    end

    module PublicTags
      class << self 
        @@temp_tegs_result = ''

        def input name = 'name', as: :input, **args
          # require 'byebug'; byebug;
          tag_name = as == :text ? 'textarea' : 'input'

          @@temp_tegs_result += Tag.build tag_name, { name: name, **args } do 
            yield if block_given? 
          end
        end

        # TODO: make it private
        def reset
          temp_tegs_result = ''
        end
      end
    end
  end

  class << self
    def form_for(_entity = {})
      result = Tag.build "form", { action: "#", method: "post" } do
        result = yield Tag::PublicTags if block_given?

        Tag::PublicTags.reset()
        result 
      end
    end
  end
end


# User = Struct.new(:name, :job, keyword_init: true)
# user = User.new name: 'rob', job: 'hexlet'

# result = HexletCode.form_for user do |f|
#   f.input :name
#   f.input :job, as: :text
# end

# p result