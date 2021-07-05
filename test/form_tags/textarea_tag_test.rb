# frozen_string_literal: true

require_relative '../test_helper'

class TextareaTagTest < Minitest::Test
  extend MiniTest::Spec::DSL
  it 'should render form input textarea with value and label' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new name: 'john doe', job: 'hexlet'

    form = HexletCode.form_for user do |f|
      f.input :job, as: :text
    end

    assert_have_tag form, "label[for='job']", 'job'
    assert_have_tag form, "textarea[name='job'][id='job']", 'hexlet'
  end

  it 'should render form input textarea without value and label' do
    user_struct = Struct.new(:name, :job, keyword_init: true)
    user = user_struct.new name: 'john doe', job: ''

    form = HexletCode.form_for user do |f|
      f.input :job, as: :text
    end

    assert_have_tag form, "label[for='job']", 'job'
    assert_have_tag form, "textarea[name='job'][id='job']"
  end
end
