require "rails_helper"

describe "Admin Invoices Index Page" do
  before :each do
  

    @c1 = Customer.create!(first_name:"lucifer", last_name: "Demon")
    @c2 = Customer.create!(first_name: "Hell", last_name: "666")

    @i1 = Invoice.create!(customer_id: @c1.id, status: 1)
    @i2 = Invoice.create!(customer_id: @c1.id, status: 2)
    @i3 = Invoice.create!(customer_id: @c2.id, status: 2)
    @i4 = Invoice.create!(customer_id: @c2.id, status: 2)
    visit admin_invoices_path
  end

  it "should list all invoice ids in the system as links to their show page" do
    expect(page).to have_link("Invoice ##{@i1.id}")
    expect(page).to have_link("Invoice ##{@i2.id}")
    expect(page).to have_link("Invoice ##{@i3.id}")
    expect(page).to have_link("Invoice ##{@i4.id}")
  end
end
