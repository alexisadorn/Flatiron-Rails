require 'rails_helper'

describe 'Route to view' do
  it 'has an index page' do
    visit coupons_path
    expect(page.status_code).to eq(200)
  end
end

describe 'Multiple coupons are shown' do
  it 'on the index page' do
    Coupon.create(coupon_code: "ASD123", store: "Chipotle")
    Coupon.create(coupon_code: "XYZ098", store: "Jamba")
    visit coupons_path
    expect(page).to have_content(/Chipotle|Jamba/)
  end
end

describe 'form page' do
  it 'form renders with the new action' do
    visit new_coupon_path
    expect(page).to have_content("Coupon Form")
  end

  it 'new form submits content and renders form content' do
    visit new_coupon_path

    fill_in 'coupon_code', with: "YAYFREE"
    fill_in 'store', with: "Hobby Lobby"

    click_on "Submit Coupon"

    expect(page).to have_content("YAYFREE")
  end

  it 'creates a record in the database' do
    visit new_coupon_path

    fill_in 'coupon_code', with: "FREEITEM"
    fill_in 'store', with: "Quip"

    click_on "Submit Coupon"

    expect(Coupon.last.store).to eq("Quip")
  end
end

describe 'Show page' do
  before do
    @coupon = Coupon.create(coupon_code: "FREESTUFF", store: "Chipotle")
  end

  it 'renders properly' do
    visit coupon_path(@coupon)
    expect(page.status_code).to eq(200)
  end

  it 'renders the coupon code in a h1 tag' do
    visit coupon_path(@coupon)
    expect(page).to have_css("h1", text: "FREESTUFF")
  end

  it 'renders the store name in a h1 tag' do
    visit coupon_path(@coupon)
    expect(page).to have_css("h1", text: "Chipotle")
  end
end

describe 'linking from the index page to the show page' do
  it 'index page links to coupon page' do
    linked_coupon = Coupon.create(coupon_code: "FREESTUFF", store: "Chipotle")
    visit coupons_path
    expect(page).to have_link(linked_coupon.coupon_code, href: coupon_path(linked_coupon))
  end
end