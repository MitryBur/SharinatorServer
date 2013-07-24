class Event < ActiveRecord::Base
		has_many :members
		has_many :users, through: :members
    has_many :expenses
end
