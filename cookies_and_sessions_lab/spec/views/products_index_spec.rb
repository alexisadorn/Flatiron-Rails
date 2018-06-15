require 'rails_helper'

RSpec.describe "products/index", :type => :view do
  before do
    controller.singleton_class.class_eval do
      protected
        def cart
          session[:cart]
        end
        helper_method :cart
    end
  end

  it "shows everything in the cart" do
    session[:cart] = ['apples', 'bananas', 'pears']
    render
    expect(rendered).to include 'apples'
    expect(rendered).to include 'bananas'
    expect(rendered).to include 'pears'
  end
end
