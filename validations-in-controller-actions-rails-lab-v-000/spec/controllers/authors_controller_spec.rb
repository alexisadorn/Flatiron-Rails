require "rails_helper"

RSpec.describe AuthorsController do
  let(:jeff) { Author.create!(name: "H. Jeff", email: "jeff@sbahj.info") }
  let(:jeff_found) { Author.find_by(email: jeff.email) }

  describe "showing an author" do
    it "shows an author" do
      get :show, id: jeff.id
      expect(jeff_found.id).to eq(jeff.id)
    end
  end

  describe "creating a valid author" do
    let(:bro_found) { Author.find_by(name: "S. Bro") }

    before { post :create, name: "S. Bro", email: "bro@sbahj.info" }

    it "creates successfully" do
      expect(bro_found).to be_a(Author)
    end

    it "redirects to show page" do
      expect(response).to redirect_to(author_path(bro_found))
    end
  end

  describe "creating an invalid author" do
    let(:bad_attributes) { { email: jeff.email } }
    let(:jeff_bad) { Author.create(bad_attributes) }

    it "does not create" do
      expect(jeff_bad).to be_new_record
    end

    it "has an error for missing name" do
      expect(jeff_bad.errors[:name]).to_not be_empty
    end

    it "has an error for non-unique email" do
      expect(jeff_bad.errors[:email]).to_not be_empty
    end

    it "renders the form again" do
      post :create, bad_attributes
      expect(response).to render_template(:new)
    end
  end
end
