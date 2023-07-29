require "rails_helper"

describe "Admin Dashboard Index Page" do
  before :each do
   

    @c1 = Customer.create!(first_name: "John", last_name: "Doe")
    @c2 = Customer.create!(first_name: "Jane", last_name: "Smith")
    @c3 = Customer.create!(first_name: "Michael", last_name: "Johnson")
    @c4 = Customer.create!(first_name: "Emily", last_name: "Brown")
    @c5 = Customer.create!(first_name: "William", last_name: "Davis")
    @c6 = Customer.create!(first_name: "Sophia", last_name: "Miller")

    @i1 = Invoice.create!(customer_id: @c1.id, status: 'in progress')
    @i2 = Invoice.create!(customer_id: @c1.id, status: 'completed')
    @i3 = Invoice.create!(customer_id: @c2.id, status: 'completed')
    @i4 = Invoice.create!(customer_id: @c3.id, status: 'completed')
    @i5 = Invoice.create!(customer_id: @c4.id, status: 'completed')

    @t1 = Transaction.create!(invoice_id: @i1.id, credit_card_number: "00000", credit_card_expiration_date: 1.year.from_now, result: 1)
    @t2 = Transaction.create!(invoice_id: @i2.id, credit_card_number: "00000", credit_card_expiration_date: 1.year.from_now, result: 1)
    @t3 = Transaction.create!(invoice_id: @i3.id, credit_card_number: "00000", credit_card_expiration_date: 1.year.from_now, result: 1)
    @t4 = Transaction.create!(invoice_id: @i4.id, credit_card_number: "00000", credit_card_expiration_date: 1.year.from_now, result: 1)
    @t5 = Transaction.create!(invoice_id: @i5.id, credit_card_number: "00000", credit_card_expiration_date: 1.year.from_now, result: 1)

    # Visit the Admin Dashboard Index Page
    visit admin_dashboard_index_path
  end

  it "should display a header indicating the admin dashboard" do
    expect(page).to have_content("Admin Dashboard")
  end

  it "should have link to admin invoice index" do
    expect(page).to have_link("Invoices")

    click_link "Invoices"
    expect(current_path).to eq(admin_invoices_path)
  end

  it "should display the top 5 customers with the largest number of successful transactions" do
    expect(page).to have_content("Customer Transactions")
    expect(page).to have_content("First Name")
    expect(page).to have_content("Last Name")
    expect(page).to have_content("Number of Transactions")

    expect(page).to have_content(@c1.first_name)
    expect(page).to have_content(@c2.first_name)
    expect(page).to have_content(@c3.first_name)
    expect(page).to have_content(@c4.first_name)
  end

  it "should display the number of successful transactions for each top customer" do
    expect(page).to have_content(@c1.number_of_transactions)
    expect(page).to have_content(@c2.number_of_transactions)
    expect(page).to have_content(@c3.number_of_transactions)
    expect(page).to have_content(@c4.number_of_transactions)
    expect(page).not_to have_content(@c5.number_of_transactions)
  end

  it "should display a list of Invoice IDs and Items that have not been shipped" do
    expect(page).to have_content("Incomplete Invoices")


    expect(page).not_to have_content(@i2.id)
    expect(page).not_to have_content(@i4.id)
    expect(page).not_to have_content(@i5.id)
  end

end
