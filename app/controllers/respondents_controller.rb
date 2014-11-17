class RespondentsController < ApplicationController
  # This controller serves a similar role to the SessionsController in that
  # it allows respondents to access a protected poll without the need to 
  # signup or fully log-in.

  def new
  end

  def create
    @question_set = QuestionSet.find_by_title(params[:respondent][:title])
    respond_to do |format|
      if @question_set.authenticated?(params[:respondent][:password])
        session[:question_set_id] = @question_set.id
        format.html { redirect_to responses_path }
      else
        flash.now[:danger] = 'Invalid poll/password combo.'
        format.html { render action: 'new' }
      end
    end
  end
end