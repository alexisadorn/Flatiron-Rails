require "spec_helper"

describe "welcome/home.html.erb" do
  it "displays all the widgets" do
    render
    expect(rendered).to have_link('Login with Facebook', :href => '/auth/facebook')
  end
end