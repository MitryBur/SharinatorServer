class RenameSocialId < ActiveRecord::Migration
  def change
			rename_column :socials, :social_id, :vk_id
  end
end
