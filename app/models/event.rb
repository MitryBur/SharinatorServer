class Event < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :expenses
  has_one :owner, class_name: 'User'

  accepts_nested_attributes_for :users

  validates_presence_of :title, :owner_id
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|png)\Z}i,
      message: 'Must be a URL for GIF, JPG or PNG image'
  }
end
