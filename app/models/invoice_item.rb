class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
  :item_id,
  :quantity,
  :unit_price,
  :status

belongs_to :invoice
belongs_to :item

  enum status: {
                'packaged': 0,
                'pending': 1,
                'shipped': 2
                }
end
  