require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "content must not be empty" do
    question = Question.new
    assert question.invalid?
    assert question.errors[:content].any?
  end
end
