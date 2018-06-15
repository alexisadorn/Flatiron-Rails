require 'rails_helper'

RSpec.describe StaticController, type: :controller do
  include Capybara::DSL
  render_views

  describe "GET home" do
    it "renders the home template with the default layout" do
      visit :home
      expect(response).to render_template("home")
      expect(response).to render_template("layouts/application")

      expect(page.find("h1").text).to eq("Flatiron Widgets Store")
      expect(page.find("h2").text).to eq("Welcome to Flatiron Widgets")
    end
  end
end
