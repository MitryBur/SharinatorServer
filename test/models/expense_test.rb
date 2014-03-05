require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase
  fixtures :expenses
  test 'Expense is not valid without event_id' do
    e = expenses(:no_event_id)
    assert e.invalid?
  end

  test 'Expense is valid if event_id exists' do
    e = expenses(:with_event_id)
    assert e.valid?
  end
end
