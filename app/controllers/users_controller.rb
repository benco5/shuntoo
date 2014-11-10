class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    respond_to do |format|
      if @user.save
        log_in @user
        flash[:success] = "Welcome aboard!"
        format.html { redirect_to question_sets_path }
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
