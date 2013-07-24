class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.references :event, index: true
      t.float :amount
      t.text :description

      t.timestamps
    end
    create_table :expenses_users, :id => false do |t|
      t.references :expense, :user
    end

    add_index :expenses_users, [:expense_id, :user_id]
  end
end
