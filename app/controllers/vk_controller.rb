require 'net/http'
require 'net/https'
require 'json'

class VkController < ApplicationController
    def request_vk_api params
	    @url = URI.parse "https://api.vk.com/method/#{params[:method]}?#{params[:vk_params]}&access_token=#{params[:token]}"
	    http = Net::HTTP.new(@url.host, @url.port)
	    http.use_ssl = true
	    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	    http.get(@url.to_s)
    end
	def authenticate
    token = params[:access_token]
    @uid = params[:user_id]

    if !token.empty?
      @res = request_vk_api token: token, method: 'users.get', vk_params:"#{@uid}"
	    @resBody = @res.body
	    jsonRes = JSON.parse @resBody
	    @exists = 'User exists'
	    @user_data = jsonRes['response'][0]
	    unless User.find_by_social_id "#{@uid}"
			    @exists = 'User did not exist. Created one, buddy.'
					create_user social_id: @uid, name: @user_data['first_name'], surname: @user_data['last_name']
	    end
    end
  end

  def create_user params
	  @user = User.create social_id: params[:social_id]
	  @social = Social.create social_id: params[:social_id], name: params[:name], surname: params[:surname]
		@user.social = @social
  end
end
