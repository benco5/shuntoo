class ChoicesController < ApplicationController
  before_action :set_choice, only: [:show, :edit, :update, :destroy]

  # GET /choices
  # GET /choices.json
  def index
    @choices = Choice.all
  end

  # GET /choices/1
  # GET /choices/1.json
  def show
  end

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
        format.json { render action: 'show', status: :created, location: @choice }
      else
        format.html { render action: 'new' }
        format.json { render json: @choice.errors, status: :unprocessable_entity }
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
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @choice.errors, status: :unprocessable_entity }
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
      format.json { head :no_content }
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
