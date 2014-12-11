require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest


  def setup
    @user = users(:bob)
  end


  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end


  test "login with valid information" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to menu_url
    follow_redirect!
    assert_template 'question_sets/index'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    # assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    #assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    # assert_not_nil cookies['remember_token']
    assert_equal assigns(:user).remember_token, cookies['remember_token']
  end

  test "login without remembering (i.e., with forgetting)" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end

  # test "should be correct user but is wrong" do
  #   log_in_as(@user)
  #   get user_path(users(:jim))
  #   assert_redirected_to '/'
  # end

  # test "should be correct user and is correct" do
  #   log_in_as(@user)
  #   get user_path(users(:bob))
  #   assert_template 'user/show'
  # end
end
