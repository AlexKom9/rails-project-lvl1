# frozen_string_literal: true

require_relative '../test_helper'

class InputTextTagTest < Minitest::Test
  extend MiniTest::Spec::DSL
  it 'should render form input without value and with label' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new

    form = HexletCode.form_for user do |f|
      f.input :name
    end

    assert_have_tag form, "label[for='name']", 'name'
    assert_have_tag form, "input[type='text'][value=''][id='name']"
  end

  it 'should render form input with value and label' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new name: 'john doe'

    form = HexletCode.form_for user do |f|
      f.input :name
      f.submit
    end

    assert_have_tag form, "label[for='name']", 'name'
    assert_have_tag form, "input[name='name'][value='john doe'][id='name'][type='text']"
  end

  it 'should render crrect name for input' do
    user_struct = Struct.new(:test, :job, keyword_init: true)
    user = user_struct.new test: 'john doe'

    form = HexletCode.form_for user do |f|
      f.input :test
    end

    assert_have_tag form, "input[name='test'][id='test']"
  end

  it 'should render custom id for input and label' do
    user_struct = Struct.new(:test, :job, keyword_init: true)
    user = user_struct.new test: 'john doe'

    form = HexletCode.form_for user do |f|
      f.input :test, id: :test_name_id
    end

    assert_have_tag form, "label[for='test_name_id']", 'test'
    assert_have_tag form, "input[name='test'][id='test_name_id']"
  end

  it 'should render form input with class name' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new name: 'john doe'

    form = HexletCode.form_for user do |f|
      f.input :name, class: 'user-input'
    end

    assert_have_tag form, "input.user-input[name='name'][value='john doe'][id='name'][type='text']"
  end
end
