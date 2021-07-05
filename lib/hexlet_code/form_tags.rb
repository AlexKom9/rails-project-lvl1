# frozen_string_literal: true

module HexletCode
  private_constant :FormTags

  module FormTags
    autoload :Base, 'hexlet_code/form_tags/base'
    autoload :Input, 'hexlet_code/form_tags/input'
    autoload :Select, 'hexlet_code/form_tags/select'
    autoload :Textarea, 'hexlet_code/form_tags/textarea'
    autoload :Checkbox, 'hexlet_code/form_tags/checkbox'
    autoload :Submit, 'hexlet_code/form_tags/submit'
  end
end
