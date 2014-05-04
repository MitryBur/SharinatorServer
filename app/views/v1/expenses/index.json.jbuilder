json.array!(@expenses) do |expense|
    json.extract! expense, :title, :event_id, :price, :description
    json.payer do |json|
      json.(expense.payer, :id, :created_at, :updated_at)
      json.social_profile do |json|
        json.(expense.payer.social_profile, :name, :surname, :vk_access_token)
      end
    end
    json.debtors debtors_for_expense(expense) do |debtor|
      json.(debtor, :id, :created_at, :updated_at)
      json.social_profile do |json|
        json.(debtor.social_profile, :name, :surname, :vk_access_token)
      end
    end
    json.debtors debtors_for_expense(expense) do |debtor|
      json.(debtor, :id, :created_at, :updated_at)
      json.social_profile do |json|
        json.(debtor.social_profile, :name, :surname, :vk_access_token)
      end
    end

end
