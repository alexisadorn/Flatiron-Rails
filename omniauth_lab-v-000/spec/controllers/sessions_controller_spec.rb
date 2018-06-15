require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  before(:each) do
    User.destroy_all
  end

  let(:user) {User.create(:name => "Blake Johnson", :uid => 1234567
    )}

  describe 'get create' do
    it 'finds user if it exists and logs the user in' do
      auth = {
        :provider => 'facebook',
        :uid => user.uid,
        :info => {
          :email => 'blake@flatironschool.com',
          :name => user.name
        }
      }
      auth = ActiveSupport::HashWithIndifferentAccess.new(auth)
      @request.env['omniauth.auth'] = auth
      get :create
      expect(@request.session[:user_id]).to eq(user.id)
    end

    it 'creates user if it doesnt exist in the db' do
      auth = {
        :provider => 'facebook',
        :uid => '1234567',
        :info => {
          :email => 'blake@flatironschool.com',
          :name => 'Blake Johnson'
        }
      }
      auth = ActiveSupport::HashWithIndifferentAccess.new(auth)
      @request.env['omniauth.auth'] = auth
      get :create
      expect(@request.session[:user_id]).to eq(1)
    end

    it "create the user correctly" do
      name = 'Blake Johnson'
      auth = {
        :provider => 'facebook',
        :uid => '1234567',
        :info => {
          :email => 'blake@flatironschool.com',
          :name => name
        }
      }
      auth = ActiveSupport::HashWithIndifferentAccess.new(auth)
      @request.env['omniauth.auth'] = auth
      get :create
      create_user = User.first
      expect(create_user.name).to eq(name)
    end
  end
end
