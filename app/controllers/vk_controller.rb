require 'net/http'
require 'net/https'

class VkController < ApplicationController
  def authenticate
    token = params[:access_token]
    uid = params[:user_id]
    if !token.empty?
      #User.create :user_id=> 111, :social_id=>222;
      @url = URI.parse "https://api.vk.com/method/friends.get?uid=#{uid}&access_token=#{token}"
      http = Net::HTTP.new(@url.host, @url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      res = http.get(@url.to_s)
      @resBody = res.body
    end
  end
end
