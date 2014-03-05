class Expense < ActiveRecord::Base
  belongs_to :event
  belongs_to :payer, class_name: 'User'
  has_many :debts
  accepts_nested_attributes_for :payer
  validates :event_id, presence: true
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|png)\Z}i,
      message: 'Must be a URL for GIF, JPG or PNG image'
  }
end
