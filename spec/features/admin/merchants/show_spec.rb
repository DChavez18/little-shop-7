require "rails_helper"

RSpec.describe "admin merchants show page", :vcr do

  let!(:little_kin_shop) { create(:merchant, name: "Dave Schools") }
  let!(:red_roses) { create(:merchant, name: "Sunny") }
  let!(:halloween_face) { create(:merchant, name: "JB") }
  let!(:tall_boy) { create(:merchant) }
  let!(:arleen) { create(:merchant) }
  let!(:bust_it_big) { create(:merchant) }

  before do
    visit admin_merchant_path(little_kin_shop)
  end

  it "displays merchant name on show page" do
    expect(page).to have_content(little_kin_shop.name)
    expect(page).to_not have_content(red_roses.name)
  end

  it "provides link to update merchant info" do
    click_link "Update Merchant"
    expect(current_path).to eq(edit_admin_merchant_path(little_kin_shop))
  end

end