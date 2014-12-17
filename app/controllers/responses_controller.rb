class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :edit, :update, :destroy]
  before_action :check_box_responses, only: :create
  before_action :set_question_set_from_session_hash, only: :new
  before_action :set_question_from_session_hash, only: :new

  def new
  end

  def create
    @response = Response.create(response_params)
  end

  def destroy
  end


  private

    def set_question_set_from_session_hash
      @question_set = QuestionSet.find_by(id: session[:question_set_id])
    end

    def set_question_from_session_hash
      @question = Question.find_by(id: session[:question_id])
    end

    # Enumerate through array of responses returned by checkbox submissions,
    # sets params for each response and submits to create action.
    # When all responses have been created, calls respond_to_create
    def check_box_responses              
      if params["response"]["responses"]  # Evals to true if checkbox submission                                                     
        p = params                                            
        h = params["response"]["responses"]                   
        h.each do |response|  # Goes through response for each checkbox                                 
          p["response"] = response 
          unless params["response"]["choice_id"].nil?
            params
            create
          end
        end
      else # Evals if radio submission
        create
      end
      respond_to_create
    end

    # Because checkbox responses may require multiple insertions, the following
    # respond_to is executed after (potentially) multiple create actions.
    # Also, resets question to next in set until last question is reached.
    def respond_to_create    
      set_question_set_from_session_hash
      set_question_from_session_hash                                 
      respond_to do |format|                                   
        if @response.save
          if @question == @question_set.questions.last
            reset_session unless signed_in?
            format.html { redirect_to root_url,
              notice: "Thanks for your input. Come again soon!" }
          else
            session[:question_id] = @question.next.id              
            format.html { redirect_to new_response_path }
          end                                    
        else
          reset_session unless signed_in?
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
