class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
  end

  # POST /responses
  def create
    @response = Response.create(response_params)
    respond_to do |format|
      if @response.save
          format.html { redirect_to :back }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def set_response
      @response = Response.find(params[:id])
    end

    def response_params
      params.require(:response).permit(:id, :pip, :choice_id)
    end
end
