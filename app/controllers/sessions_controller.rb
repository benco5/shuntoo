class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    respond_to do |format|
      if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        format.html { redirect_to question_sets_path }
      else
        flash.now[:danger] = 'Invalid email/password combination'
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    log_out if signed_in?
    redirect_to root_url
  end
end
