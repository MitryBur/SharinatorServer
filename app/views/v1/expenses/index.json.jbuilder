json.array!(@expenses) do |expense|
  json.extract! expense, :title, :event_id, :price, :description
  json.debts expense.debts do |debt|
     if debt
       json.(debt, :id, :amount, :debtor_id, :creditor_id)
     end
  end
end
