# frozen_string_literal: true

require_relative "hexlet_code/version"
require "byebug"

module HexletCode
  class Error < StandardError; end

  @@entity = {}
  @@temp_tegs_result = ""

  # Your code goes here...

  # HTML tags builder module
  module Tag
    class Error < StandardError; end

    class << self
      def build(type, params = {})
        if block_given?
          "<#{type}#{prams_to_attr params}>#{yield}</#{type}>"
        else
          "<#{type}#{prams_to_attr params}/>"
        end
      end

      private

      def prams_to_attr(params)
        params.reduce("") { |accum, (key, value)| accum + " #{key}='#{value}'" }
      end
    end

    # module PublicTags

    # end
  end

  class << self 
    def form_for(entity)
      @@entity = entity
      reset()
  
      Tag.build "form", { action: "#", method: "post" } do
        result = yield self if block_given?
        reset()
        result
      end
    end

    def input(fieldName, as: :input, **args)
      tag_name = as == :text ? "textarea" : "input"

      if tag_name === "textarea"
        @@temp_tegs_result += Tag.build tag_name, { name: fieldName, **args } do
          @@entity[fieldName]
        end

      else
        @@temp_tegs_result += Tag.build tag_name, { name: fieldName, value: @@entity[fieldName], **args }
      end

      @@temp_tegs_result += "\n"
    end

    private

    def reset
      @@temp_tegs_result = "\n"
    end
  end
end

# User = Struct.new(:name, :job, keyword_init: true)
# user = User.new name: "rob", job: "hexlet"

# result = HexletCode.form_for user do |f|
#   f.input :name
#   f.input :job, as: :text
# end

# pp result
