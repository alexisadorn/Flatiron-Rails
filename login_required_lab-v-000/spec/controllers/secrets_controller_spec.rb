require 'rails_helper'

RSpec.describe SecretsController do
  describe 'get show' do
    it "should redirect to login if you're not logged in" do
      get :show
      expect(response).to redirect_to controller: 'sessions', action: 'new'
    end

    it "should show you the secret if you're logged in" do
      # note, in this test we're sending a get request to the secretscontroller with no params.
      # if your route expects a param of id you'll get this error No route matches {:action=>"show", :controller=>"secrets"}
      get :show, nil, {name: 'Maya Angelou'}
      assert_response 200
    end
  end
end
