class QuestionSetsController < ApplicationController
  before_action :signed_in_user
  before_action :set_question_set, only: [:reset_response_token, :show, :edit, :update, :destroy]
  before_action :set_question_formats, only: [:show, :new, :create, :edit, :update]
  

  def reset_response_token
    respond_to do |format|
      if @question_set.remember
        session_for_new_response_token
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back }
      end
    end
  end


  def index
    @question_sets = current_user.question_sets.order('created_at DESC')
    @question_set = QuestionSet.find_by(id: session[:question_set_id]) # Solely for modal, after token reset
    session[:response_tokens] ||= {}
    session.delete(:question_set_id)
  end


  def show
    if @question_set.questions.any?
      @questions = @question_set.questions
    end
  end


  def new
    @question_set = QuestionSet.new
    3.times do
      question = @question_set.questions.build
      4.times { question.choices.build }
    end
  end


  def edit
  end


  def create
    @question_set = current_user.question_sets.build(question_set_params)
    respond_to do |format|
      if @question_set.save
        @question_set.remember
        session_for_new_response_token
        format.html { redirect_to menu_url(@question_set) }
      else
        format.html { render action: 'new' }
      end
    end
  end


  def update
    respond_to do |format|
      if @question_set.update(question_set_params)
        format.html { redirect_to @question_set, notice: 'Question set was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end


  def destroy
    @question_set.destroy
    respond_to do |format|
      format.html { redirect_to menu_url }
    end
  end

  private

    def set_question_set
      @question_set = QuestionSet.find(params[:id])
      session[:question_set_id] = @question_set.id
    end


    def question_set_params
      params.require(:question_set).permit(:id, :title, :user_id, :response_token,
        questions_attributes: [:id, :content, :_destroy, :question_format_id, 
        choices_attributes: [:id, :content, :_destroy]])
    end
end
