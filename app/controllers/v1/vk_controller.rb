require 'net/http'
require 'net/https'
require 'json'
require 'vk_api'

class V1::VkController < ApplicationController
  #before_filter :restrict_access, :except => :authenticate


  def index
    vk_oauth_base = "https://oauth.vk.com/authorize"
    app_id = "3984515"

    #vk_access_token_address = "https://api.vk.com/oauth/access_token"
    #@vk_oauth_url = "#{vk_access_token_address}?client_id=#{app_id}&client_secret=#{secret_key}&grant_type=client_credentials"

    redirect_uri = url_for controller: 'v1/vk', action: 'get_access_token'
    @vk_oauth_url = "#{vk_oauth_base}?client_id=#{app_id}&response_type=code&display=popup&redirect_uri=#{redirect_uri}&scope=offline"

  end


  def get_access_token
    params.require(:code)
    app_secret = "HxkhUwxMrELhkANIXMYE"
    app_id = "3984515"

    #redirect_uri = url_for controller: 'v1/vk', action: 'authenticate'
    redirect_uri = url_for controller: 'v1/vk', action: 'get_access_token'
    token_url = "https://oauth.vk.com/access_token?client_id=#{app_id}&client_secret=#{app_secret}&code=#{params[:code]}&redirect_uri=#{redirect_uri}"
    response = VkAPI.request_url token_url

    render text: "Ok!" + response.body
  end



  def authenticate
    require_vk_auth_params

    @vk_access_token = params[:access_token]
    @uid = params[:user_id]


    #send request
    httpResponse = VkAPI.request token: @vk_access_token, method: 'users.get', vk_params: "uids=#{@uid}"

    vk_access = VKAccessResponse.new httpResponse
    if (!vk_access.permitted?)
      render json: vk_access.get_error_message
      return
    end

    user_data = vk_access.get_user_data

    user = User.joins(:social_profile).where(social_profiles: {vk_id: @uid}).first

    if !user
      create_user vk_id: @uid, name: user_data['first_name'], surname: user_data['last_name'], vk_token: @vk_access_token
      #message = 'User did not exist. Created one, buddy.'
      render json: user, status: :created
      return
    elsif !user.social_profile.vk_access_token.eql? @vk_access_token
      user.social_profile.update vk_access_token: @vk_access_token
      #'Token updated.'
      render json: user, status: :accepted
      return
    end
    render json: user, status: :ok
  end

  def get_friends
    fields = 'fields=first_name,last_name,sex&order=name'
    token = params[:access_token]
    @res = VkAPI.request token: token, method: 'friends.get', vk_params:"#{fields}"
    render json: @res.body
  end

  private
  def require_vk_auth_params
    params.require(:access_token)
    params.require(:user_id)
  end

  def create_user params
    @user = User.create
    @social = SocialProfile.create vk_id: params[:vk_id], name: params[:name], surname: params[:surname], vk_access_token: params[:vk_token]
    @user.social_profile = @social
    @user
  end


  def restrict_access
    token = params[:access_token]
    unless token && SocialProfile.find_by_vk_access_token(token)
      head :unauthorized
    end
  end
end

class VKAccessResponse
  def initialize httpResponse
    @json_response = JSON.parse httpResponse.body
  end

  def permitted?
    !@json_response['error']
  end

  def get_error_message
    @json_response['error']['error_msg']
  end

  def get_user_data
    @json_response['response'][0]
  end
end
