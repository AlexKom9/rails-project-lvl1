# frozen_string_literal: true

require_relative 'test_helper'

class HexletCodeTest < Minitest::Test
  extend MiniTest::Spec::DSL

  it 'should has a version_number' do
    refute_nil ::HexletCode::VERSION
  end

  it 'should render form with default action and method' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new

    form = HexletCode.form_for user, &:submit

    assert_includes form, "<form action='#' method='post'>"
    assert_includes form, '</form>'
  end

  it 'should render form with custom action and method' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new

    form = HexletCode.form_for user, '/test', 'PATCH', &:submit

    assert_includes form, "<form action='/test' method='PATCH'>"
    assert_includes form, '</form>'
  end

  it 'should render submit button' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new

    form = HexletCode.form_for user, &:submit

    assert_includes form, "<input type='submit' value='Save' name='commit'/>"
  end

  it 'should render submit button with text and className' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new

    form = HexletCode.form_for user do |f|
      f.submit 'Save changes', class: 'submit-btn'
    end

    assert_includes form, "<input type='submit' class='submit-btn' value='Save changes' name='commit'/>"
  end

  it 'should render form input without value and with label' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new

    form = HexletCode.form_for user do |f|
      f.input :name
    end

    assert_includes form, "<label for='name'>name</label>"
    assert_includes form, "<input name='name' value='' id='name' type='text'/>"
  end

  it 'should render form input with value and label' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new name: 'john doe'

    form = HexletCode.form_for user do |f|
      f.input :name
      f.submit
    end

    assert_includes form, "<label for='name'>name</label>"
    assert_includes form, "<input name='name' value='john doe' id='name' type='text'/>"
  end

  it 'should render crrect name for input' do
    user_struct = Struct.new(:test, :job, keyword_init: true)
    user = user_struct.new test: 'john doe'

    form = HexletCode.form_for user do |f|
      f.input :test
    end

    assert_includes form, "<input name='test' value='john doe' id='test' type='text'/>"
  end

  it 'should render custom id for input and label' do
    user_struct = Struct.new(:test, :job, keyword_init: true)
    user = user_struct.new test: 'john doe'

    form = HexletCode.form_for user do |f|
      f.input :test, id: :test_name_id
    end

    assert_includes form, "<label for='test_name_id'>test</label>"
    assert_includes form, "<input name='test' value='john doe' id='test_name_id' type='text'/>"
  end

  it 'should render form input textarea with value and label' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new name: 'john doe', job: 'hexlet'

    form = HexletCode.form_for user do |f|
      f.input :job, as: :text
    end

    assert_includes form, "<label for='job'>job</label>"
    assert_includes form, "<textarea name='job' id='job'>hexlet</textarea>"
  end

  it 'should render form input textarea without value and label' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new name: 'john doe', job: ''

    form = HexletCode.form_for user do |f|
      f.input :job, as: :text
    end

    assert_includes form, "<label for='job'>job</label>"
    assert_includes form, "<textarea name='job' id='job'></textarea>"
  end

  it 'should render form input with class name' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new name: 'john doe'

    form = HexletCode.form_for user do |f|
      f.input :name, class: 'user-input'
    end

    assert_includes form, "<input name='name' value='john doe' id='name' type='text' class='user-input'/>"
  end

  it 'should render form select with options' do
    user_struct = Struct.new(:name, :job, :gender, keyword_init: true)
    user = user_struct.new name: 'john doe', gender: 'f'

    form = HexletCode.form_for user do |f|
      f.input :gender, as: 'select', options: %w[f m]
    end

    assert_includes form, "<label for='gender'>gender</label>"
    assert_includes form, "<select name='gender' value='f' id='gender'>"
    assert_includes form, "<option value='f'>f</option>"
    assert_includes form, "<option value='m'>m</option>"
    assert_includes form, '</select>'
  end

  it 'should render checked checkbox with label' do
    user_struct = Struct.new(:like_fish, keyword_init: true)
    user = user_struct.new like_fish: true

    form = HexletCode.form_for user do |f|
      f.input :like_fish, as: 'checkbox'
    end

    assert_includes form, "<label for='like_fish'>like_fish</label>"
    assert_includes form, "<input name='like_fish' checked='true' value='like_fish' id='like_fish' type='checkbox'/>"
  end

  it 'should render unchecked checkbox with label' do
    user_struct = Struct.new(:like_fish, keyword_init: true)
    user = user_struct.new like_fish: false

    form = HexletCode.form_for user do |f|
      f.input :like_fish, as: 'checkbox'
    end

    assert_includes form, "<label for='like_fish'>like_fish</label>"
    assert_includes form, "<input name='like_fish' checked='false' value='like_fish' id='like_fish' type='checkbox'/>"
  end
end
