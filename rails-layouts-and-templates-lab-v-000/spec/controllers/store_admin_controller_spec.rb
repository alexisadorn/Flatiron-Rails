require 'rails_helper'

RSpec.describe StoreAdminController, type: :controller do
  include Capybara::DSL
  render_views

  describe "GET home" do
    it "renders the home template with admin layout" do
      visit 'admin/home'

      expect(response).to render_template("home")
      expect(response).to render_template("layouts/admin")

      expect(page.find("h1").text).to eq("Flatiron Widgets: Admin")
      expect(page.find("h2").text).to eq("Welcome Flatiron Admin")
    end
  end

  describe "GET orders" do
    it "renders the orders template with order_administration layout" do
      visit 'admin/orders'

      expect(response).to render_template("orders")
      expect(response).to render_template("layouts/order_administration")

      expect(page.find("h1").text).to eq("Flatiron Widgets: Open Orders")
      expect(page.find("h2").text).to eq("Welcome to Flatiron Open Orders")
      expect(page.all("ol li").size).to be >= 1
    end
  end

  describe "GET invoice" do
    it "renders the invoice template without any layout" do
      visit 'admin/invoice'

      expect(response).to render_template("invoice")
      assert_template layout: false

      expect(page.find("h1").text).to eq("Your Invoice")
    end
  end
end
