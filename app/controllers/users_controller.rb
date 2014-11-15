class UsersController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :update]

  def show
  end

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

  def edit
  end

  def update
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
