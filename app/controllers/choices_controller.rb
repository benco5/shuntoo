class ChoicesController < ApplicationController
  before_action :set_choice, only: [:update, :destroy]


  # GET /choices/new
  def new
    @question = Question.find(session[:question_id])
    @choice = Choice.new
  end

  # GET /choices/1/edit
  def edit
    @question = Question.find(session[:question_id])
    @question_set = @choice.question_set
  end

  # POST /choices
  # POST /choices.json
  def create
    @question = Question.find(session[:question_id])
    @choice = @question.choices.build(choice_params)
    respond_to do |format|
      if @choice.save
        format.html { redirect_to @question.question_set, notice: 'Choice was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /choices/1
  # PATCH/PUT /choices/1.json
  def update
    @question = Question.find(session[:question_id])
    respond_to do |format|
      if @choice.update(choice_params)
        format.html { redirect_to @choice, notice: 'Choice was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /choices/1
  # DELETE /choices/1.json
  def destroy
    @question = Question.find(session[:question_id])
    @choice.destroy
    respond_to do |format|
      format.html { redirect_to @question.question_set }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_choice
      @choice = Choice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def choice_params
      params.require(:choice).permit(:id, :content, responses_attributes: [:id, :pip, :_destroy])
    end
end
