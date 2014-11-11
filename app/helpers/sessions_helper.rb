module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember                                             # Assigns new token to user and stores digest
    cookies.permanent.signed[:user_id] = user.id              # Sets encrypted user id to cookie
    cookies.permanent[:remember_token] = user.remember_token  # Sets encrypted user token to cookie
  end

  # Assigns current user from session if not cookies
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Set user to current user
  def current_user=(user)
    @current_user = user
  end

  # Checks whether user is current user
  def current_user?(user)
    @current_user == user
  end

  # Checks whether current user is signed in (not nil)
  def signed_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logout current user by deleting from session and setting instance to nil
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
