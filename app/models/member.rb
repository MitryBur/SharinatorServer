class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates_uniqueness_of :user_id, :scope => [:event_id], message: 'Already exists'

end
