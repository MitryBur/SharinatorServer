class V1::EventsController < ApplicationController
		before_filter :restrict_access
		before_action :set_event, only: [:show, :edit, :update, :destroy]
    respond_to :json
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.owner_id = (Social.find_by_vk_token params[:access_token]).user_id
    if @event.save
      render action: 'show', status: :created, location: [:v1, @event]
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if @event.update(event_params)
      head :no_content
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description)
    end

		def restrict_access
				token = params[:access_token]
				unless token && Social.find_by_vk_token(token)
						head :unauthorized
				end
    end
end
