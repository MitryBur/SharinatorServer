require 'net/http'
require 'net/https'
require 'json'

class VkController < ApplicationController
	before_filter :restrict_access, :except => :authenticate
	def authenticate
    token = params[:access_token]
    @uid = params[:user_id]
    if token.empty?
        render text: 'Error: Davai token, bleat!'
        return
    end
    @res = VkAPI.request token: token, method: 'users.get', vk_params:"#{@uid}"
	  @resBody = @res.body
	  jsonRes = JSON.parse @resBody
    if jsonRes['error']
        render json: jsonRes
        return
    end

	  @exists = 'User exists'
	  @user_data = jsonRes['response'][0]
    @user = User.first(include: :social, conditions: {socials: {vk_id: @uid}})
	  if !@user
			@exists = 'User did not exist. Created one, buddy.'
			create_user vk_id: @uid, name: @user_data['first_name'], surname: @user_data['last_name'], vk_token: token
    elsif !@user.social.vk_token.eql? token
      @user.social.vk_token = token
    end
    render text: 'Success!'
  end


	def get_friends
		fields = "fields=first_name,last_name,sex"
		token = params[:access_token]
    @res = VkAPI.request token: token, method: 'friends.get', vk_params:"#{fields}"
		render json: @res.body
	end

	private
    def create_user params
				@user = User.create
				@social = Social.create vk_id: params[:vk_id], name: params[:name], surname: params[:surname], vk_token: params[:vk_token]
				@user.social = @social
				@user
    end


		def restrict_access
			token = params[:access_token]
			unless token && Social.find_by_vk_token(token)
					head :unauthorized
			end
		end
end
