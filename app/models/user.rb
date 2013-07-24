class User < ActiveRecord::Base
	has_one :social, dependent: :destroy
	has_many :members
	has_many :events, through: :members
  has_and_belongs_to_many :expenses
end
