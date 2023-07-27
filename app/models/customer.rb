class Customer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name
  
  has_many :invoices
  has_many :invoice_items, through: :invoices 
  has_many :items, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :merchants, through: :items

 

  def number_of_transactions
    transactions
      .where('result = ?', 1)
      .count
  end
end