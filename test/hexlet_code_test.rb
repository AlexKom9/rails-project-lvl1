# frozen_string_literal: true

require_relative 'test_helper'

class HexletCodeTest < Minitest::Test
  extend MiniTest::Spec::DSL

  it 'should has a version_number' do
    refute_nil ::HexletCode::VERSION
  end

  it 'should render form input' do
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

  it 'should render form input with value' do
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

  it 'should render form input textarea with value' do
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
    assert_includes form, "<textarea name='job' id='job'>hexlet</textarea>"
    assert_includes form, "<input type='submit' value='Save' name='commit'/>"
    assert_includes form, '</form>'
  end

  it 'should render form input with class name' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new name: 'john doe'

    form = HexletCode.form_for user do |f|
      f.input :name, class: 'user-input'
      f.submit
    end

    assert_includes form, "<form action='#' method='post'>"
    assert_includes form, "<label for='name'>name</label>"
    assert_includes form, "<input name='name' value='john doe' id='name' type='text' class='user-input'/>"
    assert_includes form, "<input type='submit' value='Save' name='commit'/>"
    assert_includes form, '</form>'
  end

  # TODO: add specs for select and radio
end
