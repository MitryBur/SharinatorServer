class V1::UsersController < ApplicationController

	#before_filter :restrict_access
	before_action :set_user, only: [:show, :update, :destroy]
  respond_to :json


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      render action: 'show', status: :created, location: [:v1, @user]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:social_profile_attributes => [:name, :surname, :vk_id, :vk_access_token])
    end


    #Pass token through content-type
    #"def restrict_access
			#authenticate_or_request_with_http_token do |access_token|
			#		SocialProfile.exists? vk_token: access_token
			#end
    #end"


    #Pass token as parameter
		def restrict_access
			token = params[:access_token]
			unless token && SocialProfile.find_by_vk_access_token(token)
				head :unauthorized
			end
    end


end
