require 'vk_api'
require 'json'

class V1::MembersController < ApplicationController
		before_filter :restrict_access
		before_action :set_member, only: [:show, :edit, :update, :destroy]
    respond_to :json
  # GET /members
  # GET /members.json
  def index
    @members = Member.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)
    vk_id = member_params[:user_id]
    user = User.first(include: :social, conditions: {socials: {vk_id: vk_id}})
    unless user
      fields = "fields=first_name,last_name,sex"
      token = member_params[:access_token]
      res = VkAPI.request token: token, method: 'users.get', vk_params:"uids=#{vk_id}&#{fields}"
      resBody = res.body
      jsonRes = JSON.parse resBody
      if jsonRes['error']
        render json: jsonRes
        return
      end
      user_data = jsonRes['response'][0]
      user = create_user vk_id: vk_id, name: user_data['first_name'], surname: user_data['last_name']
    end
    @member.user = user
    if @member.save
      render action: 'show', status: :created, location: [:v1, @member]
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    if @member.update(member_params)
      head :no_content
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    format.json { head :no_content }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:user_id, :event_id)
    end

    def restrict_access
				token = params[:access_token]
				unless token && Social.find_by_vk_token(token)
						head :unauthorized
				end
    end

    def create_user params
      @user = User.create
      @social = Social.create vk_id: params[:vk_id], name: params[:name], surname: params[:surname], vk_token: nil
      @user.social = @social
      @user
    end
end
