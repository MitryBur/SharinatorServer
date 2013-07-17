class RemoveUserid < ActiveRecord::Migration
  def change
	  remove_column :users, :idr
  end
end
