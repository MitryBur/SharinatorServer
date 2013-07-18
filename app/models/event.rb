class Event < ActiveRecord::Base
		has_many :members
		has_many :users, through: :members
		#accepts_nested_attributes_for :users
end
