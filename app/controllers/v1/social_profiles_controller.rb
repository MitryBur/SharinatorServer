class V1::SocialProfilesController < ApplicationController
		#before_filter :restrict_access
		before_action :set_social, only: [:show, :update, :destroy]
    respond_to :json
  # GET /social_profiles
  # GET /social_profiles.json
  def index
    @social_profiles = SocialProfile.all
  end

  # GET /social_profiles/1
  # GET /social_profiles/1.json
  def show
  end

  # POST /social_profiles
  # POST /social_profiles.json
  def create
    @social_profile = SocialProfile.create(social_profile_params)#where(:vk_id => social_profile_params[:vk_id]).first_or_initialize(social_profile_params)
    if @social_profile.save
      render action: 'show', status: :created, location: [:v1, @social_profile]
    else
      render json: @social_profile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /social_profiles/1
  # PATCH/PUT /social_profiles/1.json
  def update
    if @social_profile.update(social_profile_params)
      head :no_content
    else
      render json: @social_profile.errors, status: :unprocessable_entity
    end
  end

  # DELETE /social_profiles/1
  # DELETE /social_profiles/1.json
  def destroy
    @social_profile.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_social
      @social_profile = SocialProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def social_profile_params
      params.require(:social_profile).permit(:name, :surname, :vk_id)
    end

		def restrict_access
				token = params[:access_token]
				unless token && SocialProfile.find_by_vk_access_token(token)
						head :unauthorized
				end
    end
end
