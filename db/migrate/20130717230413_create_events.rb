class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :title
      t.string :owner_id
      t.text :description

      t.timestamps
    end
  end
end
