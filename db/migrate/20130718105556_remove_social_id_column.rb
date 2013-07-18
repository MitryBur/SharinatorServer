class RemoveSocialIdColumn < ActiveRecord::Migration
  def change
			remove_column :users, :social_id
  end
end
