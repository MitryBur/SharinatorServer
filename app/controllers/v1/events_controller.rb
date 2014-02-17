class V1::EventsController < ActionController::Base
  #before_filter :restrict_access
  before_action :set_event, only: [:show, :update, :destroy]

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
    #Split event_params into nested attributes and event attributes
    #event_params_without_nested = event_params.dup
    #event_params_without_nested.delete :users_attributes
    #@event = Event.create(event_params_without_nested)

    if event_params[:users_attributes]
      event_params[:users_attributes].each do |u|
        SocialProfile.where(:vk_id=>u[:social_profile_attributes][:vk_id]).load.delete_all
      end
    end

    @event = Event.new(event_params)

    #TODO move this shit to SocialProfile
    @event.owner_id = (SocialProfile.find_by_vk_access_token params[:access_token]).user_id
    @event.users << User.find(@event.owner_id);

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
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :image_url, :owner_id, :users_attributes => [:social_profile_attributes => [:name, :surname, :vk_id, :vk_access_token]])
  end


  def restrict_access
  	token = params[:access_token]
  	unless token && SocialProfile.find_by_vk_access_token(token)
  			head :unauthorized
  	end
  end
end

