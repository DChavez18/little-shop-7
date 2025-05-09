class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices 
  has_many :items, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :merchants, through: :items
  validates :first_name, presence: true
  validates :last_name, presence: true


  def number_of_transactions
    transactions.count

  end

  def list_transactions_results
    transactions.pluck(:result)
  end
end