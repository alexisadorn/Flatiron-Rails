class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:name].present?
      session[:name] = params[:name]
      redirect_to :root
    else
      redirect_to :login
    end
  end

  def destroy
    if session[:name].present?
      session.delete :name
    end
    redirect_to :login
  end
end
