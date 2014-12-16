require 'test_helper'

class ResponseFlowTest < ActionDispatch::IntegrationTest


  def setup
    @question_set = question_sets(:one)
  end

  test "attempt to respondent login with invalid information" do
    get respond_path
    assert_template 'respondents/new'
    post respond_path, respondent: { title: @question_set.title, password: "" }
    assert_template 'respondents/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "respondent login with valid information" do
    get respond_path
    assert_template 'respondents/new'
    post respond_path, respondent: { title: @question_set.title, password: 'token' }
    assert_redirected_to new_response_path
    follow_redirect!
    assert_template 'responses/new'
  end
end
