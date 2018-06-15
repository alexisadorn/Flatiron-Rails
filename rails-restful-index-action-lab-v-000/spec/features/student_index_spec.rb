require 'rails_helper'

describe 'Route to view' do
  it 'has an index page' do
    visit "/students"

    expect(page.status_code).to eq(200)
  end
end

describe 'Multiple students are shown' do
  it 'on the index page' do
    Student.create!(first_name: "Daenerys", last_name: "Targaryen")
    Student.create!(first_name: "Lindsey", last_name: "Stirling")

    visit "/students"

    expect(page).to have_content(/(?=.*Daenerys)(?=.*Lindsey).*/)
  end
end
