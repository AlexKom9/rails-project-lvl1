# frozen_string_literal: true

require_relative '../test_helper'

class SelectTagTest < Minitest::Test
  extend MiniTest::Spec::DSL
  it 'should render form select with options' do
    user_struct = Struct.new(:name, :job, :gender, keyword_init: true)
    user = user_struct.new name: 'john doe', gender: 'f'

    form = HexletCode.form_for user do |f|
      f.input :gender, as: 'select', options: %w[f m]
    end

    assert_have_tag form, "label[for='gender']", 'gender'
    assert_have_tag form, "select[name='gender'][value='f'][id='gender']"
    assert_have_tag form, "option[value='f']", 'f'
    assert_have_tag form, "option[value='m']", 'm'
  end
end
