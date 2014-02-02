class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :title
      t.text :description
      t.text :image_url
      t.integer :owner_id, :null => false
      t.timestamps
    end

    create_table :events_users, :id => false do |t|
      t.references :event, :user
    end
    add_index :events_users, [:event_id, :user_id]
  end
end
