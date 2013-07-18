class Event < ActiveRecord::Base
		has_many :attendances
		has_many :users, through: :attendances

		def add_attendance id

		end
end
