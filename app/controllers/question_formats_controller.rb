class QuestionFormatsController < ApplicationController
  before_action :set_question_format, only: [:show, :edit, :update, :destroy]

  # GET /question_formats
  def index
    @question_formats = QuestionSet.all
  end

  # GET /question_formats/1
  def show
    if @question_format.questions.any?
      @questions = @question_format.questions
    end
  end

  # GET /question_formats/new
  def new
    @question_format = QuestionSet.new
  end

  # GET /question_formats/1/edit
  def edit
  end

  # POST /question_formats
  def create
    @question_format = QuestionSet.new(question_format_params)
    respond_to do |format|
      if @question_format.save
        session[:question_format_id] = @question_format.id
        format.html { redirect_to @question_format, notice: 'Question set was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /question_formats/1
  def update
    respond_to do |format|
      if @question_format.update(question_format_params)
        format.html { redirect_to @question_format, notice: 'Question set was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /question_formats/1
  def destroy
    @question_format.destroy
    respond_to do |format|
      format.html { redirect_to question_formats_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_format
      @question_format = QuestionFormat.find(params[:id])
      session[:question_format_id] = @question_format.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_format_params
      params.require(:question_format).permit(:id, :name)
    end
end


end
