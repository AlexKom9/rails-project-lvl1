# frozen_string_literal: true

require_relative 'test_helper'

class HexletCodeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_should_render_form_input
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new

    form = HexletCode.form_for user do |f|
      f.input :name
      f.submit
    end

    assert_includes form, "<form action='#' method='post'>"
    assert_includes form, "<label for='name'>name</label>"
    assert_includes form, "<input name='name' value='' id='name' type='text'/>"
    assert_includes form, "<input type='submit' value='Save' name='commit'/>"
    assert_includes form, '</form>'
  end

  def test_should_render_form_input_with_value
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new name: 'john doe'

    form = HexletCode.form_for user do |f|
      f.input :name
      f.submit
    end

    assert_includes form, "<form action='#' method='post'>"
    assert_includes form, "<label for='name'>name</label>"
    assert_includes form, "<input name='name' value='john doe' id='name' type='text'/>"
    assert_includes form, "<input type='submit' value='Save' name='commit'/>"
    assert_includes form, '</form>'
  end

  def test_should_render_form_input_textarea_with_value
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new name: 'john doe', job: 'hexlet'

    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
      f.submit
    end

    assert_includes form, "<form action='#' method='post'>"
    assert_includes form, "<label for='name'>name</label>"
    assert_includes form, "<input name='name' value='john doe' id='name' type='text'/>"
    assert_includes form, "<label for='job'>job</label>"
    assert_includes form, "<textarea name='job' id='job' type='text'>hexlet</textarea>"
    assert_includes form, "<input type='submit' value='Save' name='commit'/>"
    assert_includes form, '</form>'
  end

  def test_should_render_form_input_with_class_name
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new name: 'john doe'

    form = HexletCode.form_for user do |f|
      f.input :name, class: 'user-input'
      f.submit
    end

    assert_includes form, "<form action='#' method='post'>"
    assert_includes form, "<label for='name'>name</label>"
    assert_includes form, "<input name='name' value='john doe' class='user-input' id='name' type='text'/>"
    assert_includes form, "<input type='submit' value='Save' name='commit'/>"
    assert_includes form, '</form>'
  end
end
