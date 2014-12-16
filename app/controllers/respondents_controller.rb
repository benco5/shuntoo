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
        session[:question_id] = @question_set.questions.first.id
        format.html { redirect_to new_response_path }
      else
        flash.now[:danger] = "Dang! That doesn't look right."
        format.html { render action: 'new' }
      end
    end
  end
end