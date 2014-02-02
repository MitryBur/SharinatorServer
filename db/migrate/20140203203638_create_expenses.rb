class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.references :event, index: true
      t.float :price
      t.text :currency
      t.text :title
      t.text :description
      t.date :due_date
      t.text :image_url

      t.integer :payer_id, :null => false
      t.timestamps
    end
    create_table :expenses_users, :id => false do |t|
      t.references :expense, :user
    end
    add_index :expenses_users, [:expense_id, :user_id]
  end
end
