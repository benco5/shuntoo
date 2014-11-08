class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to question_sets_path, notice: 'Signup completed.' }
      else
        format.html { render action: 'new' }
      end
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
