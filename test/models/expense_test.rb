require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase

  test "Expense is not valid withot event_id" do
    e = expenses(:no_event_id)
    assert !e.valid?
  end

  test "Expense is valid if event_id exists" do
    e = expenses(:with_event_id)
    assert e.valid?
  end

  # test "the truth" do
  #   assert true
  # end
end
