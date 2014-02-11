class User < ActiveRecord::Base
	has_one :social_profile, dependent: :destroy
  has_and_belongs_to_many :events
  has_many :expenses
  has_many :debts
  #before_create :check_social_profile
  accepts_nested_attributes_for :social_profile#, :reject_if => proc {|attributes| SocialProfile.where(:vk_id=>attributes['vk_id']).first}

=begin
    private
    def check_social_profile
      unless SocialProfile.where(:vk_id=>attributes['vk_id']).first
        return false
      end
      return true
    end
=end
end
