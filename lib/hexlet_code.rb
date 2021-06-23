# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

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
  end

  @@entity = {}
  @@temp_tegs_result = ""

  class << self
    def form_for(entity)
      @@entity = entity
      reset

      Tag.build "form", { action: "#", method: "post" } do
        result = yield self if block_given?
        reset
        result
      end
    end

    def input(field_name, as: :input, **args)
      tag_name = as == :text ? "textarea" : "input"

      id = args.fetch("id", field_name)

      build_label field_name, id
      build_input field_name, tag_name, **args, id: id
    end

    def submit(text = "Save", **args)
      add_tag do
        Tag.build "input", { type: "submit", **args, value: text, name: "commit" }
      end
    end

    private

    def build_input(field_name, tag_name, **args)
      if tag_name === "textarea"
        add_tag do
          Tag.build(tag_name, { name: field_name, **args }) { @@entity[field_name] }
        end
      else
        add_tag { Tag.build(tag_name, { name: field_name, value: @@entity[field_name], **args }) }
      end
    end

    def build_label(title, html_for, **args)
      add_tag do
        Tag.build("label", { for: html_for, **args }) { title }
      end

      add_new_line
    end

    def reset
      @@temp_tegs_result = "\n"
    end

    def add_new_line
      @@temp_tegs_result += "\n"
    end

    def add_tag
      @@temp_tegs_result += yield

      add_new_line
    end
  end
end
