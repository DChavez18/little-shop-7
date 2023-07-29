require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  it { should validate_presence_of(:invoice_id) }
  it { should validate_presence_of(:item_id) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:unit_price) }
  it { should validate_presence_of(:status) }

  it { should belong_to(:invoice) }
  it { should belong_to(:item) }
  it { should define_enum_for(:status).with_values(packaged: 0, pending: 1, shipped: 2) }

  it "returns a list of incomplete invoices" do
    completed_invoice = create(:invoice, status: 'completed')
    incomplete_invoice1 = create(:invoice, status: 'in progress')
    incomplete_invoice2 = create(:invoice, status: 'cancelled')

    create(:invoice_item, invoice: completed_invoice, status: 'shipped')
    create(:invoice_item, invoice: incomplete_invoice1, status: 'packaged')
    create(:invoice_item, invoice: incomplete_invoice2, status: 'pending')

    incomplete_invoices = InvoiceItem.incomplete_invoices

    expect(incomplete_invoices).to include(incomplete_invoice1)
    expect(incomplete_invoices).to include(incomplete_invoice2)
    expect(incomplete_invoices).not_to include(completed_invoice)
  end

  describe "#instance_methods" do
    describe "#format_price" do
      it "converts unit_price in cents to dollars" do
        merchant = FactoryBot.create(:merchant)
        customer = FactoryBot.create(:customer)
        invoice = FactoryBot.create(:invoice, customer: customer)
        item = FactoryBot.create(:item, merchant: merchant)
        
        invoice_item = InvoiceItem.create!(quantity: 8, unit_price: 90210, status: "pending", invoice_id: invoice.id, item_id: item.id)

        formatted_price = invoice_item.format_price

        expect(formatted_price).to eq("$902.10")
      end
    end
  end
end