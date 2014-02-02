class Expense < ActiveRecord::Base
  validates :event_id, presence: true

  belongs_to :event
  belongs_to :payer, class_name: 'User'
  has_many :debts
  #accepts_nested_attributes_for :users
end
