require 'test_helper'

class SuiteTest < ActiveSupport::TestCase

  fixtures :suites
  fixtures :questions

  setup do
    @suite = suites(:one)
  end

  test "must have title" do
  	suite = Suite.new
    assert suite.invalid?
    assert suite.errors[:title].any?
  end

  test "must have correct title" do
    assert_equal @suite.title, "Lecture_1"
  end

  test "suite builds question through association" do
    @question = @suite.questions.build(content: "How are you?")
    @question.save!
    assert @suite
    assert @question
    assert @suite.questions.any?
    assert_equal @question.content, "How are you?"
  end
end
