class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :edit, :update, :destroy]
  before_action :check_box_responses, only: :create
  before_action :question_set_id_nil?, only: :index

  def index
    @question_set = QuestionSet.find(session[:question_set_id])
    @questions = @question_set.questions.paginate(:page => params[:page])
    session[:question_set_id] = nil
  end

  def show
    @question_set = QuestionSet.find(session[:question_set_id])
    @questions = @question_set.questions.paginate(:page => params[:page])
  end

  def new
    @question_set = QuestionSet.find(session[:question_set_id])
    @question = Question.find(session[:question_id])
  end

  def create
    @response = Response.create(response_params)
  end

  def edit
  end

  def update
    @response = Response.update(response_params)
    respond_to do |format|
      if @response.save
          format.html { redirect_to :back }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
  end

  private

    def question_set_id_nil?
      unless session[:question_set_id]
        redirect_to root_url
      end
    end

    # Enumerate through array of responses returned by checkbox submissions,
    # sets params for each response and submits to create action.
    # When all responses have been inserted, calls respond_to_create
    def check_box_responses                                   
      if params["response"]["responses"]                    
        action = params[:action]                              
        p = params                                            
        h = params["response"]["responses"]                   
        h.each do |response|                                 
          p["response"] = response
          unless params["response"]["choice_id"].nil?
            params
            create
          end
        end
      else
        create
      end
      respond_to_create
    end

    # Standard issue respond_to, but must be executed after (potentially)
    # multiple create actions resulting from array of checkbox responses
    def respond_to_create
      @question_set = QuestionSet.find(session[:question_set_id])
      @question = Question.find(session[:question_id])                                      
      respond_to do |format|                                   
        if @response.save
          if @question == @question_set.questions.last
            session.delete
            format.html { redirect_to root_url,
              notice: "Thanks for your input. Come again soon!" }
          else
            session[:question_id] = @question.next.id              
            format.html { redirect_to new_response_path }
          end                                    
        else
          session.delete 
          format.html { redirect_to root_url,
            notice: "Houston, there was a problem :(" }
        end
      end
    end

    def set_response
      @response = Response.find(params[:id])
    end

    def response_params
      params.require(:response).permit(:choice_id, :pip)      
    end
end
