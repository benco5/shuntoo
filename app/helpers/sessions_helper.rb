module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    @current_user == user
  end

  def signed_in?
    !current_user.nil?
  end

  def log_out
    session[:user_id] = nil
  end
end
