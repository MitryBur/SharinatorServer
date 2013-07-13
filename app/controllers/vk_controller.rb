class VkController < ApplicationController
  def authenticate
    @code = params[:code]
  end
end
