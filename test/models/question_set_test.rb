require 'test_helper'

class QuestionSetTest < ActiveSupport::TestCase
  def setup
    @question_set = QuestionSet.new(title: "Lecture X", user_id: 5, response_token: "a13k-4l_")
  end

  test "should be valid" do
    assert @question_set.valid?
  end

  test "title should be present" do
    @question_set.title = "     "
    assert_not @question_set.valid?
  end

  test "user id should be present" do
    @question_set.user_id = " "
    assert_not @question_set.valid?
  end

  test "response token should be present" do
    @question_set.response_token = " "
    assert_not @question_set.valid?
  end

  test "title should not be too long" do
    @question_set.title = 'a' * 51
    assert_not @question_set.valid?
  end

  test "title should not be too short" do
    @question_set.title = 'a' * 3
    assert_not @question_set.valid?
  end

  test "title validation should accept valid titles" do
    valid_titles = ["Quiz Time 1", "QUESTION liST", "10 pr0blems"]
    valid_titles.each do |valid_title|
      @question_set.title = valid_title
      assert @question_set.valid?, "#{valid_title.inspect} should be valid"
    end
  end

  test "title validation should reject invalid titles" do
    invalid_titles = %w[Lecture.4 Quiz-Test I+want_answers]
    invalid_titles.each do |invalid_title|
      @question_set.title = invalid_title
      assert_not @question_set.valid?, "#{invalid_title.inspect} should be invalid"
    end
  end

  test "titles should be unique" do
    duplicate_question_set = @question_set.dup
    @question_set.save
    assert_not duplicate_question_set.valid?
  end

  test "authenticated? should return false for a question_set with nil digest" do
    assert_not @question_set.authenticated?('')
  end
end
