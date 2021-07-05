# frozen_string_literal: true

require_relative '../test_helper'

class SubmitInputTagTest < Minitest::Test
  extend MiniTest::Spec::DSL
  it 'should render submit button' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new

    form = HexletCode.form_for user, &:submit

    assert_have_tag form, "input[type='submit'][value='Save'][name='commit']"
  end

  it 'should render submit button with text and className' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new

    form = HexletCode.form_for user do |f|
      f.submit 'Save changes', class: 'submit-btn'
    end

    assert_have_tag form, "input.submit-btn[type='submit'][value='Save changes'][name='commit']"
  end
end
