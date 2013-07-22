class VkAPI
	def self.request params
		@url = URI.parse "https://api.vk.com/method/#{params[:method]}?#{params[:vk_params]}&access_token=#{params[:token]}"
		http = Net::HTTP.new(@url.host, @url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		http.get(@url.to_s)
	end
end