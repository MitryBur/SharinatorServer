class SocialProfile < ActiveRecord::Base
	belongs_to :user
  validates_presence_of :name, :surname, :vk_id
  validates_uniqueness_of :vk_id
  validates_uniqueness_of :vk_access_token, allow_blank: true
end
