class SocialidToInteger < ActiveRecord::Migration
  def change
		  change_column :socials, :social_id, :integer
		  change_column :users, :social_id, :integer
  end
end
