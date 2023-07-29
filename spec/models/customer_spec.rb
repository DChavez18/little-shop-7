require "rails_helper"

RSpec.describe Customer, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  it { should have_many(:invoices) }
  it { should have_many(:invoice_items).through(:invoices) }
  it { should have_many(:items).through(:invoice_items) }
  it { should have_many(:transactions).through(:invoices) }
  it { should have_many(:merchants).through(:items) }

  it "returns the correct number of transactions" do
    customer = create(:customer)
    create_list(:transaction, 5, invoice: create(:invoice, customer: customer))
    expect(customer.number_of_transactions).to eq(5)
  end

  it "returns a list of transactions results" do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)
    create_list(:transaction, 3, invoice: invoice, result: 'success')
    create_list(:transaction, 2, invoice: invoice, result: 'failed')

    expect(customer.list_transactions_results).to contain_exactly('success', 'success', 'success', 'failed', 'failed')
  end
end
