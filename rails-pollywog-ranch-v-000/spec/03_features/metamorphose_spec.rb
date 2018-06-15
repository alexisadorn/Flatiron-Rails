require 'rails_helper'

describe "Metamorphose" do
  before(:each) do
    @pond = Pond.create(:name => "Swan", :water_type => "alkaline")
    @frog = Frog.create(:name => "Ribbit", :color => "green",  :pond_id => @pond.id)
    @tadpole = Tadpole.create(:name => "Polly", :color => "tan", :frog_id => @frog.id)
    visit "/tadpoles/#{@tadpole.id}"
  end

  it "has a button called 'Become a frog' on the tadpole show page" do
    expect(page).to have_button('Become a frog')
  end

  it "can click on the button and the tadpole becomes a frog" do
    click_button('Become a frog')

    # deletes the tadpole from the database
    expect(Tadpole.find_by(:name => @tadpole.name)).to be_nil

    # makes a frog with the same name and color of the tadpole
    frog = Frog.find_by(:name => @tadpole.name)
    expect(frog.color).to eq(@tadpole.color)
    expect(frog.pond).to eq(@tadpole.pond)

    # redirects to the newly made frog's show page
    expect(current_url).to eq("http://www.example.com/frogs/#{frog.id}")

    # displays the frog's color
    expect(page).to have_content(@tadpole.color)
    # displays the frog's name
    expect(page).to have_content(@tadpole.name)
    # displays the frog's pond's name
    expect(page).to have_content(@tadpole.pond.name)
  end
end