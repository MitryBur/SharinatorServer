class Debt < ActiveRecord::Base
  belongs_to :debtor, class_name: 'User', foreign_key:'debtor_id'
  belongs_to :creditor, class_name: 'User', foreign_key:'creditor_id'
  belongs_to :expense
  validates :amount, numericality:  {greater_than_or_equal_to: 0.01}
  validates_presence_of :amount, :debtor, :creditor

end
