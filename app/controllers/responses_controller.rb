class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :edit, :update, :destroy]
  before_action :check_box_responses, only: :create

  def show
  end

  def new
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

    def respond_to_create                                     # Standard issue respond_to, but
     respond_to do |format|                                   # must be executed after (potentially)
        if @response.save                                     # multiple create actions resulting 
            format.html { redirect_to :back }                 # from array of checkbox responses
        else
          format.html { render action: 'new' }
        end
      end
    end

    def check_box_responses                                   # Enumerate through array of responses
      if params["response"]["responses"]                      # returned by checkbox submissions,
        action = params[:action]                              # sets params for each response
        p = params                                            # and submits to create action.
        h = params["response"]["responses"]                   # When all responses have been inserted,
        h.each do |response|                                  # calls respond_to_create
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

    def set_response
      @response = Response.find(params[:id])
    end

    def response_params
      params.require(:response).permit(:id, :choice_id, :pip)      
    end
end
