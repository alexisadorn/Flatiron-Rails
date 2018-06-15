class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  helper_method :cart

  def index
  end

  def add
    cart << params[:product]
    render :index
  end
end
