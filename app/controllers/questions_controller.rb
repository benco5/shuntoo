class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_question_formats, only: [:show, :new, :create, :edit, :update]
  before_action :set_question_format, only: [:show, :new, :edit, :update]
  
  def create_response
    @response = Response.create(question_params)
  end

  # GET /questions
  def index
    @questions = Question.all
  end

  # GET /questions/1
  def show
    # @question_set = QuestionSet.find(session[:question_set_id])
    @question_set = @question.question_set
    @questions = @question_set.questions.paginate(:page => params[:page])
    @choices = @question.choices
  end

  # GET /questions/new
  def new
    @question_set = QuestionSet.find(session[:question_set_id])
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    @question_set = QuestionSet.find(session[:question_set_id])
    session[:question_id] = @question.id
  end

  # POST /questions
  def create
    @question_set = QuestionSet.find(session[:question_set_id])
    @question = @question_set.questions.build(question_params)
    respond_to do |format|
      if @question.save
        session[:question_id] = @question.id
        if params[:commit] == 'Save'
          format.html { redirect_to @question_set, notice: 'Question was successfully created.' }
        elsif params[:commit] == 'Save & Add Choice'
          format.html { redirect_to new_choice_path, notice: 'Question was successfully created.' }
        end
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /questions/1
  def update
    @question_set = QuestionSet.find(session[:question_set_id])
    respond_to do |format|
      if @question.update(question_params)
        session[:question_id] = @question.id
        if params[:commit] == 'Save'
          format.html { redirect_to @question_set, notice: 'Question was successfully updated.' }
        elsif params[:commit] == 'Save & Add Choice'
          format.html { redirect_to new_choice_path, notice: 'Question was successfully updated.' }
        end
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /questions/1
  def destroy
    @question_set = QuestionSet.find(session[:question_set_id])
    @question.destroy
    respond_to do |format|
      format.html { redirect_to @question_set }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:id, :content,
        :question_set_id, :question_format_id, choices_attributes: [:id, :content, :_destroy,
        responses_attributes: [:id, :pip, :_destroy]])
    end
end
