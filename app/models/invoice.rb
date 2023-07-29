class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  
  # scope :top_customers, -> {
  #   joins(customer: :transactions)
  #     .select('customers.id AS customer_id, customers.first_name, customers.last_name, COUNT(*) AS number_of_transactions, ARRAY_AGG(transactions.result) AS list_transactions_results')
  #     #  .where('transactions.result = ?','success')
  #     .group('customers.id, customers.first_name, customers.last_name')
  #     .order('number_of_transactions DESC')
  #     .limit(5)
  # }

  scope :customer_transactions_count, -> {
    select("customers.first_name, customers.last_name, COUNT(transactions.id) AS number_of_transactions,ARRAY_AGG(transactions.result) AS list_transactions_results")
      .joins(:customer, :transactions)
      .where("transactions.result = ?", 1)
      .group("customers.first_name, customers.last_name")
      .order("number_of_transactions DESC")
      .limit(5)
  }



  enum status: {
                  'cancelled': 0,
                  'in progress': 1,
                  'completed': 2
                  }

  def format_created_at
    created_at.strftime("%A, %B %d, %Y")
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end
end