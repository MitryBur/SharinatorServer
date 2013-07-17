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
    uid = params[:user_id]
    uid_full = 'id'+uid.to_s

    if !token.empty?
      #User.create :user_id=> 111, :social_id=>222;
	    @res = request_vk_api params: {token: token, method: 'users.get', vk_params:'#{uid}'}
	    @resBody = @res.Body
	    @exists = 'exists'
	  	if !Users.social.exists? :social_id.eql? uid_full
			  puts 'blah bla'
		    @exits = 'Does not exist'
		  end
    end
  end
  def test
	  @user = User.create social_id: 'id6157'
	  @social = Social.create social_id: 'id6151', name: 'beatch', surname: 'family'
	  @user.social = @social
  end
  def add_user_information

  end
end
