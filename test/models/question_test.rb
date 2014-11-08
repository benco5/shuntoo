require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  fixtures :questions
  fixtures :question_sets

  def setup
    @question = Question.new(
                              content: "What's up?", 
                              question_set: question_sets(:one),
                              question_format_id: 1
                            )
  end

  test "should be valid" do
    assert @question.valid?
  end

  test "content should be present" do
    @question.content = "     "
    assert_not @question.valid?
  end

  test "question set should be present" do
    @question.question_set = nil
    assert_not @question.valid?
  end

  test "question format id should be present" do
    @question.question_format_id = "     "
    assert_not @question.valid?
  end
end
