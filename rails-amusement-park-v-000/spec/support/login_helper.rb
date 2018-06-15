module LoginHelper

  def user_signup
    fill_in("user[name]", :with => "Amy Poehler")
    fill_in("user[height]", :with => "58")
    fill_in("user[happiness]", :with => "3")
    fill_in("user[nausea]", :with => "2")
    fill_in("user[tickets]", :with => "15")
    fill_in("user[password]", :with => "password")
    click_button('Create User')
  end

  def user_login
    select 'Mindy',from:'user_name'
    fill_in("password", :with => "password")
    click_button('Sign In')
  end

  def admin_signup
    fill_in("user[name]", :with => "Walt Disney")
    fill_in("user[password]", :with => "password")
    find(:css, "#user_admin").set(true)
    click_button('Create User')
  end

  def admin_login
    select 'Walt Disney',from:'user_name'
    fill_in("password", :with => "password")
    click_button('Sign In')
  end

  def create_standard_user 
    @mindy = User.create(
      name: "Mindy",
      password: "password",
      happiness: 3,
      nausea: 2,
      tickets: 10,
      height: 50
      )
  end

  def create_standard_and_admin_user
    @mindy = User.create(
      name: "Mindy",
      password: "password",
      happiness: 3,
      nausea: 2,
      tickets: 10,
      height: 50
    )
    @walt = User.create(
      name: "Walt Disney",
      password: "password",
      admin: true
    )
  end
  
end