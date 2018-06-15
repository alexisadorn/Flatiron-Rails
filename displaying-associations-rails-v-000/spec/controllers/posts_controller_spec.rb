require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET #show" do
    it "returns HTTP success" do
      get :show, id: @post
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns HTTP success" do
      get :edit, id: @post
      expect(response).to have_http_status(:success)
    end
  end
end
