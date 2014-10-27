class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]




  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
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
  # POST /questions.json
  def create
    @question_set = QuestionSet.find(session[:question_set_id])
    @question = @question_set.questions.build(question_params)
    respond_to do |format|
      if @question.save
        session[:question_id] = @question.id
        if params[:commit] == 'Save'
          format.html { redirect_to @question_set, notice: 'Question was successfully created.' }
          format.json { render action: 'show', status: :created, location: @question }
        elsif params[:commit] == 'Save & Add Choice'
          format.html { redirect_to new_choice_path, notice: 'Question was successfully created.' }
          format.json { render action: 'show', status: :created, location: @question }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @question_set = QuestionSet.find(session[:question_set_id])
    respond_to do |format|
      if @question.update(question_params)
        session[:question_id] = @question.id
        if params[:commit] == 'Save'
          format.html { redirect_to @question_set, notice: 'Question was successfully updated.' }
          format.json { head :no_content }
        elsif params[:commit] == 'Save & Add Choice'
          format.html { redirect_to new_choice_path, notice: 'Question was successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question_set = QuestionSet.find(session[:question_set_id])
    @question.destroy
    respond_to do |format|
      format.html { redirect_to @question_set }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:content)
    end
end
