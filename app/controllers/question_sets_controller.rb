class QuestionSetsController < ApplicationController
  before_action :set_question_set, only: [:show, :edit, :update, :destroy]
  before_action :set_question_formats, only: [:show, :new, :create, :edit, :update]
  

  def index
    @question_sets = current_user.question_sets
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
        session[:question_set_id] = @question_set.id
        format.html { redirect_to @question_set,
                      notice: "Success!
                      Please record your response-password:
                      #{@question_set.response_token}" }
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
      format.html { redirect_to question_sets_url }
    end
  end

  private

    def set_question_set
      @question_set = QuestionSet.find(params[:id])
      session[:question_set_id] = @question_set.id
    end


    def question_set_params
      params.require(:question_set).permit(:id, :title,
        questions_attributes: [:id, :content, :_destroy, :question_format_id, 
        choices_attributes: [:id, :content, :_destroy]])
    end
end
