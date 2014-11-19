require 'test_helper'

class ResponsesControllerTest < ActionController::TestCase

  setup do
    @myresponse = responses(:one)
    session[:question_set_id] = question_sets(:one).id
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create response" do
    assert_difference('Response.count') do
      @request.env['HTTP_REFERER'] = responses_url
      post :create, response: { pip: @myresponse.pip,
                        choice_id: @myresponse.choice_id }
    end
    assert_redirected_to responses_url
  end

  # test "should destroy response" do
  #   assert_difference('Response.count', -1) do
  #     delete :destroy, id: @myresponse.id
  #   end
  # end
end
