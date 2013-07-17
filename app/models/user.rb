class User < ActiveRecord::Base
	has_one :social, dependent: :destroy
  validates_uniqueness_of :social_id
end
