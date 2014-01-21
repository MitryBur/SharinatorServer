class V1::EventsController < ActionController::Base
  #before_filter :restrict_access
  #before_action :set_event, only: [:show, :update, :destroy]

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
    @event = Event.create(create_event_params)

    #TODO move this shit to Social
    #@event.owner_id = (Social.find_by_vk_token params[:access_token]).user_id

    if @event.save
      render action: 'show', status: :created, location: [:v1, @event]
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    #TODO params -> strong_params
    if @event.update(params)
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
  def get_event(id)
    Event.find(id)
  end


  def create_event_params
    params.require(:owner_id)
    params.require(:title)
    params.permit(:title, :description, :owner_id)
  end


  #def restrict_access
  #	token = params[:access_token]
  #	unless token && Social.find_by_vk_token(token)
  #			head :unauthorized
  #	end
  #end
end
