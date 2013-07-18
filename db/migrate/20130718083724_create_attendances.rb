class CreateAttendances < ActiveRecord::Migration
  def change
		  drop_table :attendances
		  create_table :attendances do |t|
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
