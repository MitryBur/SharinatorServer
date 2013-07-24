class Expense < ActiveRecord::Base
  belongs_to :event
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :users
end
