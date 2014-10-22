require 'test_helper'

class QuestionSetsControllerTest < ActionController::TestCase
  setup do
    @question_set = question_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:question_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question_set" do
    assert_difference('QuestionSet.count') do
      post :create, question_set: { title: @question_set.title }
    end

    assert_redirected_to question_set_path(assigns(:question_set))
  end

  test "should show question_set" do
    get :show, id: @question_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question_set
    assert_response :success
  end

  test "should update question_set" do
    patch :update, id: @question_set, question_set: { title: @question_set.title }
    assert_redirected_to question_set_path(assigns(:question_set))
  end

  test "should destroy question_set" do
    assert_difference('QuestionSet.count', -1) do
      delete :destroy, id: @question_set
    end

    assert_redirected_to question_sets_path
  end
end
