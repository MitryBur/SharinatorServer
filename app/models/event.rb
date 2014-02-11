class Event < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :expenses
  has_one :owner, class_name: 'User'

  accepts_nested_attributes_for :users
end
