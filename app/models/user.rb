class User < ActiveRecord::Base
	has_one :social_profile, dependent: :destroy
  has_and_belongs_to_many :events
  has_many :expenses
  has_many :debts
end
