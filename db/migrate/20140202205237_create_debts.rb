class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.float :amount
      t.integer :debtor_id, :null => false
      t.integer :creditor_id, :null => false
      t.references :expense
      t.timestamps
    end
  end
end
