class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_question_formats, only: [:index, :show, :new, :create, :edit, :update]
  before_action :set_question_format, only: [:show, :new, :edit, :update]

  # GET /questions
  def index
    @question_set = current_user.question_sets.find_by(id: params[:question_set_id])
    @questions = @question_set.questions.paginate(:page => params[:page])
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
