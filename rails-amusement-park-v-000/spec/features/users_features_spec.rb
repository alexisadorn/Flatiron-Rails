require_relative "../rails_helper.rb"
describe 'Feature Test: User Signup', :type => :feature do

  it 'successfully signs up as non-admin' do
    visit '/users/new'
    expect(current_path).to eq('/users/new')
    # user_signup method is defined in login_helper.rb
    user_signup
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Amy Poehler")
    expect(page).to have_content("Mood")
    expect(page).to have_content("happy")
    expect(page).to have_content("15")
    expect(page).to have_content("58")
  end

  it "on sign up, successfully adds a session hash" do
    visit '/users/new'
    # user_signup method is defined in login_helper.rb
    user_signup
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'successfully logs in as non-admin' do
    
    # user_login method is defined in login_helper.rb
    create_standard_user
    visit '/signin'
    expect(current_path).to eq('/signin')
    user_login
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Mindy")
    expect(page).to have_content("Mood")
    expect(page).to have_content("happy")
    expect(page).to have_content("10")
    expect(page).to have_content("50")
  end

  it "on log in, successfully adds a session hash" do
    create_standard_user
    visit '/signin'
    # user_login method is defined in login_helper.rb
    user_login
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'prevents user from viewing user show page and redirects to home page if not logged in' do
    create_standard_user
    visit '/users/1'
    expect(current_path).to eq('/')
    expect(page).to have_content("Sign Up")
  end

  it 'successfully signs up as admin' do
    visit '/users/new'
    expect(current_path).to eq('/users/new')
    # admin_signup method is defined in login_helper.rb
    admin_signup
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Walt Disney")
    expect(page).to have_content("ADMIN")
  end

  it "on sign up for admin, successfully adds a session hash" do
    visit '/users/new'
    # admin_signup method is defined in login_helper.rb
    admin_signup
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'successfully logs in as admin' do
    create_standard_and_admin_user
    visit '/signin'
    expect(current_path).to eq('/signin')
    # admin_login method is defined in login_helper.rb
    admin_login
    expect(current_path).to eq('/users/2')
    expect(page).to have_content("Walt Disney")
    expect(page).to have_content("ADMIN")
  end

  it "on log in, successfully adds a session hash to admins" do
    create_standard_and_admin_user
    visit '/signin'
    # admin_login method is defined in login_helper.rb
    admin_login
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

end

describe 'Feature Test: User Signout', :type => :feature do

  it 'has a link to log out from the users/show page' do
    visit '/users/new'
    # user_signup method is defined in login_helper.rb
    user_signup
    expect(page).to have_content("Log Out")
  end

  it 'redirects to home page after logging out' do
    visit '/users/new'
    # user_signup method is defined in login_helper.rb
    user_signup
    click_link("Log Out")
    expect(current_path).to eq('/')
  end

  it "successfully destroys session hash when 'Log Out' is clicked" do
    visit '/users/new'
    # user_signup method is defined in login_helper.rb
    user_signup
    click_link("Log Out")
    expect(page.get_rack_session).to_not include("user_id")
  end

  it 'has a link to log out from the users/show page when user is an admin' do
    visit '/users/new'
    # admin_signup method is defined in login_helper.rb
    admin_signup
    expect(page).to have_content("Log Out")
  end

  it 'redirects to home page after admin logs out when user is an admin' do
    visit '/users/new'
    # admin_signup method is defined in login_helper.rb
    admin_signup
    click_link("Log Out")
    expect(current_path).to eq('/')
  end

  it "successfully destroys session hash when 'Log Out' is clicked as admin" do
    visit '/users/new'
    # admin_signup method is defined in login_helper.rb
    admin_signup
    click_link("Log Out")
    expect(page.get_rack_session).to_not include("user_id")
  end
end

describe 'Feature Test: Go on a Ride', :type => :feature do

  before :each do
    @rollercoaster = Attraction.create(
      :name => "Roller Coaster",
      :tickets => 5,
      :nausea_rating => 2,
      :happiness_rating => 4,
      :min_height => 32
    )
    @ferriswheel = Attraction.create(
      :name => "Ferris Wheel",
      :tickets => 2,
      :nausea_rating => 2,
      :happiness_rating => 1,
      :min_height => 28
    )
    @teacups = Attraction.create(
      :name => "Teacups",
      :tickets => 1,
      :nausea_rating => 5,
      :happiness_rating => 1,
      :min_height => 28
    )
    visit '/users/new'
    user_signup
  end

  it 'has a link from the user show page to the attractions index page' do
    expect(page).to have_content("See attractions")
    click_link('See attractions')
  end

  it 'links from the user show page to the attractions index page' do
    click_link('See attractions')
    expect(current_path).to eq('/attractions')
  end

  it 'prevents users from editing/deleting/adding rides on the index page' do
    click_link('See attractions')
    expect(current_path).to eq('/attractions')
    expect(page).to_not have_content("edit")
    expect(page).to_not have_content("delete")
    expect(page).to_not have_content("new attraction")
  end

  it 'has titles of the rides on the attractions index page' do
    click_link('See attractions')
    expect(page).to have_content("#{@ferriswheel.name}")
    expect(page).to have_content("#{@rollercoaster.name}")
  end

  it "has links on the attractions index page to the attractions' show pages" do
    click_link('See attractions')
    expect(page).to have_content("Go on #{@ferriswheel.name}")
    expect(page).to have_content("Go on #{@rollercoaster.name}")
  end

  it "links from the attractions index page to the attractions' show pages" do
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    expect(current_path).to eq("/attractions/2")
  end

  it 'prevents users from editing/deleting a ride on the show page' do
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    expect(page).to_not have_content("edit")
    expect(page).to_not have_content("delete")
  end

  it "has a button from the attraction show page to go on the ride" do
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    expect(current_path).to eq("/attractions/2")
    expect(page).to have_button("Go on this ride")
  end

  it "clicking on 'Go on ride' redirects to user show page" do
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    click_button("Go on this ride")
    expect(current_path).to eq("/users/1")
  end

  it "clicking on 'Go on ride' updates the users ticket number" do
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    click_button("Go on this ride")
    expect(page).to have_content("Tickets: 13")
  end

  it "clicking on 'Go on ride' updates the users mood" do
    click_link('See attractions')
    click_link("Go on #{@teacups.name}")
    click_button("Go on this ride")
    expect(page).to have_content("sad")
  end

  it "when the user is tall enough and has enough tickets, clicking on 'Go on ride' displays a thank you message" do
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    click_button("Go on this ride")
    expect(page).to have_content("Thanks for riding the #{@ferriswheel.name}!")
  end

  it "when the user is too short, clicking on 'Go on ride' displays a sorry message" do
    @user = User.find_by(:name => "Amy Poehler")
    @user.update(:height => 10)
    click_link('See attractions')
    click_link("Go on #{@teacups.name}")
    click_button("Go on this ride")
    expect(page).to have_content("You are not tall enough to ride the #{@teacups.name}")
    expect(page).to have_content("happy")
  end

  it "when the user doesn't have enough tickets, clicking on 'Go on ride' displays a sorry message" do
    @user = User.find_by(:name => "Amy Poehler")
    @user.update(:tickets => 1)
    click_link('See attractions')
    click_link("Go on #{@ferriswheel.name}")
    click_button("Go on this ride")
    expect(page).to have_content("You do not have enough tickets to ride the #{@ferriswheel.name}")
    expect(page).to have_content("Tickets: 1")
  end

  it "when the user is too short and doesn't have enough tickets, clicking on 'Go on ride' displays a detailed sorry message" do
    @user = User.find_by(:name => "Amy Poehler")
    @user.update(:tickets => 1, :height => 30)
    click_link('See attractions')
    click_link("Go on #{@rollercoaster.name}")
    click_button("Go on this ride")
    expect(page).to have_content("You are not tall enough to ride the #{@rollercoaster.name}")
    expect(page).to have_content("You do not have enough tickets to ride the #{@rollercoaster.name}")
    expect(page).to have_content("Tickets: 1")
  end
end

describe 'Feature Test: Admin Flow', :type => :feature do

  before :each do
    @rollercoaster = Attraction.create(
      :name => "Roller Coaster",
      :tickets => 5,
      :nausea_rating => 2,
      :happiness_rating => 4,
      :min_height => 32
    )
    @ferriswheel = Attraction.create(
      :name => "Ferris Wheel",
      :tickets => 2,
      :nausea_rating => 2,
      :happiness_rating => 1,
      :min_height => 28
    )
    @teacups = Attraction.create(
      :name => "Teacups",
      :tickets => 1,
      :nausea_rating => 5,
      :happiness_rating => 1,
      :min_height => 28
    )
    visit '/users/new'
    admin_signup
  end

  it 'displays admin when logged in as an admin on user show page' do
    expect(page).to have_content("ADMIN")
  end

  it 'links to the attractions from the users show page when logged in as a admin' do
    expect(page).to have_content("See attractions")
  end

  it 'has a link from the user show page to the attractions index page when in admin mode' do
    click_link('See attractions')
    expect(page).to have_content("#{@teacups.name}")
    expect(page).to have_content("#{@rollercoaster.name}")
    expect(page).to have_content("#{@ferriswheel.name}")
  end

  it 'allows admins to add an attraction from the index page' do
    click_link('See attractions')
    expect(page).to have_content("New Attraction")
  end

  it 'allows admins to add an attraction' do
    click_link('See attractions')
    click_link("New Attraction")
    expect(current_path).to eq('/attractions/new')
    fill_in("attraction[name]", :with => "Haunted Mansion")
    fill_in("attraction[min_height]", :with => "32")
    fill_in("attraction[happiness_rating]", :with => "2")
    fill_in("attraction[nausea_rating]", :with => "1")
    fill_in("attraction[tickets]", :with => "4")
    click_button('Create Attraction')
    expect(current_path).to eq("/attractions/4")
    expect(page).to have_content("Haunted Mansion")
  end

  it "has link to attraction/show from attraction/index page for admins" do
    click_link('See attractions')
    expect(page).to have_content("Show #{@ferriswheel.name}")
  end

  it "does not suggest that admins go on a ride" do
    click_link('See attractions')
    expect(page).to_not have_content("Go on #{@ferriswheel.name}")
  end

  it "links to attractions/show page from attractions/index" do
    click_link('See attractions')
    click_link("Show #{@rollercoaster.name}")
    expect(current_path).to eq("/attractions/1")
  end

  it "does not suggest that an admin go on a ride from attractions/show page" do
    click_link('See attractions')
    click_link("Show #{@rollercoaster.name}")
    expect(page).to_not have_content("Go on this ride")
  end

  it "has a link for admin to edit attraction from the attractions/show page" do
    click_link('See attractions')
    click_link("Show #{@rollercoaster.name}")
    expect(page).to have_content("Edit Attraction")
  end

  it "links to attraction/edit page from attraction/show page when logged in as an admin" do
    click_link('See attractions')
    click_link("Show #{@rollercoaster.name}")
    click_link("Edit Attraction")
    expect(current_path).to eq("/attractions/1/edit")
  end

  it "updates an attraction when an admin edits it" do
    click_link('See attractions')
    click_link("Show #{@rollercoaster.name}")
    click_link("Edit Attraction")
    fill_in("attraction[name]", :with => "Nitro")
    click_button("Update Attraction")
    expect(current_path).to eq("/attractions/1")
    expect(page).to have_content("Nitro")
  end
end
