class QuestionSetsController < ApplicationController
  before_action :set_question_set, only: [:show, :edit, :update, :destroy]
  before_action :set_question_formats, only: [:show, :new, :create, :edit, :update]
  # GET /question_sets
  def index
    @question_sets = QuestionSet.all
  end

  # GET /question_sets/1
  def show
    if @question_set.questions.any?
      @questions = @question_set.questions
    end
  end

  # GET /question_sets/new
  def new
    @question_set = QuestionSet.new
    3.times do
      question = @question_set.questions.build
      4.times { question.choices.build }
    end
  end

  # GET /question_sets/1/edit
  def edit
  end

  # POST /question_sets
  def create
    @question_set = QuestionSet.new(question_set_params)
    respond_to do |format|
      if @question_set.save
        session[:question_set_id] = @question_set.id
        format.html { redirect_to @question_set, notice: 'Question set was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /question_sets/1
  def update
    respond_to do |format|
      if @question_set.update(question_set_params)
        format.html { redirect_to @question_set, notice: 'Question set was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /question_sets/1
  def destroy
    @question_set.destroy
    respond_to do |format|
      format.html { redirect_to question_sets_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_set
      @question_set = QuestionSet.find(params[:id])
      session[:question_set_id] = @question_set.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_set_params
      params.require(:question_set).permit(:id, :title,
        questions_attributes: [:id, :content, :_destroy, :question_set_id, :question_format_id, 
        choices_attributes: [:id, :content, :_destroy]])
    end
end
