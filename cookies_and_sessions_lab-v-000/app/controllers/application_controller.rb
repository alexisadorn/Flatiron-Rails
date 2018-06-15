class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :cart

  def cart
    session[:cart] ||= []
  end
end
