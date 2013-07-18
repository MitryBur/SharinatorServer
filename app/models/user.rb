class User < ActiveRecord::Base
	has_one :social, dependent: :destroy
	has_many :attendances
	has_many :events, through: :attendances
  validates_uniqueness_of :social_id
end
