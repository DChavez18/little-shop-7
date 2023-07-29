require "rails_helper"

RSpec.describe Invoice, type: :model do
  it { should belong_to(:customer) }
  it { should have_many(:invoice_items) }
  it { should have_many(:transactions) }
  it { should have_many(:items).through(:invoice_items) }
  it { should have_many(:merchants).through(:items) }

  it "calculates the total revenue correctly" do
    invoice = create(:invoice)
    item1 = create(:item)
    item2 = create(:item)

    create(:invoice_item, invoice: invoice, item: item1, quantity: 3, unit_price: 10)
    create(:invoice_item, invoice: invoice, item: item2, quantity: 2, unit_price: 20)

    expect(invoice.total_revenue).to eq(70) 
  end

  describe "#instance_methods" do
    describe "#format_created_at" do
      it "can format the created_at timestampt to resemble 'Monday, July 18, 2019'" do
        customer = Customer.create!(first_name: "Ringo", last_name: "Star")
        invoice = customer.invoices.create!(status: "completed", customer_id: 12345, created_at: 'Thu, 27 Jul 2023 21:03:33.548215000 UTC +00:00')

        expect(invoice.format_created_at).to eq('Thursday, July 27, 2023')
      end
    end

    describe "#total_revenue" do
      it "can find sum of all invoice_items unit_prices" do
        merchant = FactoryBot.create(:merchant)
        customer = FactoryBot.create(:customer)
        invoice = FactoryBot.create(:invoice, customer: customer)
        item = FactoryBot.create(:item, merchant: merchant)
        
        invoice_item_1 = InvoiceItem.create!(quantity: 8, unit_price: 100, status: "pending", invoice_id: invoice.id, item_id: item.id)
        invoice_item_2 = InvoiceItem.create!(quantity: 8, unit_price: 100, status: "pending", invoice_id: invoice.id, item_id: item.id)
        invoice_item_3 = InvoiceItem.create!(quantity: 8, unit_price: 100, status: "pending", invoice_id: invoice.id, item_id: item.id)

        expect(invoice.total_revenue).to eq(2400)
      end
    end
  end
end
