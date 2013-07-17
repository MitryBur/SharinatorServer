class RenameUserid < ActiveRecord::Migration
  def change
	  rename_column :users, :user_id, :idr
  end
end
