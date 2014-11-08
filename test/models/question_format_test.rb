require 'test_helper'

class QuestionFormatTest < ActiveSupport::TestCase
  def setup
    @question_format = QuestionFormat.new(name: "Multiple")
  end

  test "should be valid" do
    assert @question_format.valid?
  end

  test "name should be present" do
    @question_format.name = "     "
    assert_not @question_format.valid?
  end

end
