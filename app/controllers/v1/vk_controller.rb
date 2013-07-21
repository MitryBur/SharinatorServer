require 'net/http'
require 'net/https'
require 'json'

class V1::VkController < ApplicationController
	def authenticate
    token = params[:access_token]
    @uid = params[:user_id]

    if !token.empty?
      @res = VkAPI.request token: token, method: 'users.get', vk_params:"#{@uid}"
	    @resBody = @res.body
	    jsonRes = JSON.parse @resBody
	    @exists = 'User exists'
	    @user_data = jsonRes['response'][0]
      @user = User.first(include: :social, conditions: {socials: {vk_id: @uid}})
	    unless @user
			    @exists = 'User did not exist. Created one, buddy.'
					create_user vk_id: @uid, name: @user_data['first_name'], surname: @user_data['last_name']
	    end
    end
		render json: @user.to_json
	 end

  def create_user params
	  @user = User.create
	  @social = Social.create vk_id: params[:vk_id], name: params[:name], surname: params[:surname]
		@user.social = @social
		@user
  end
end
