class SocialProfile < ActiveRecord::Base
	belongs_to :user
  validates_uniqueness_of :vk_id
end
