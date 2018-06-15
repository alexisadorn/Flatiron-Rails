require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      Author.create(name: "Dennis", genre: "Ye Old Music", bio: "A really good artist")
      get :show, {:id => 1}
      expect(response).to have_http_status(:success)
    end
  end

end
