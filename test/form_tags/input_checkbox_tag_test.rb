# frozen_string_literal: true

require_relative '../test_helper'

class InputCheckboxTagTest < Minitest::Test
  extend MiniTest::Spec::DSL

  it 'should render checked checkbox with label' do
    user_struct = Struct.new(:like_fish, keyword_init: true)
    user = user_struct.new like_fish: true

    form = HexletCode.form_for user do |f|
      f.input :like_fish, as: 'checkbox'
    end

    assert_have_tag form, "label[for='like_fish']", 'like_fish'
    assert_have_tag form, "input[name='like_fish'][checked='true'][value='like_fish'][id='like_fish'][type='checkbox']"
  end

  it 'should render unchecked checkbox with label' do
    user_struct = Struct.new(:like_fish, keyword_init: true)
    user = user_struct.new like_fish: false

    form = HexletCode.form_for user do |f|
      f.input :like_fish, as: 'checkbox'
    end

    assert_have_tag form, "label[for='like_fish']", 'like_fish'
    assert_have_tag form, "input[name='like_fish'][checked='false'][value='like_fish'][id='like_fish'][type='checkbox']"
  end
end
