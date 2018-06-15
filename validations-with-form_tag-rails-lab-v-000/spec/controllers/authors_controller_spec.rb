require "rails_helper"

RSpec.describe AuthorsController do
  let(:attributes) do
    {
      name: "H. Jeff",
      email: "jeff@sbahj.info",
      phone_number: "5553059028"
    }
  end
  let(:found) { Author.find(@author.id) }

  before { @author = Author.create!(attributes) }

  describe "showing an author" do
    it "shows an author" do
      get :show, id: @author.id
      expect(found).to eq(@author)
    end
  end

  describe "creating a valid author" do
    let(:bro_attributes) do
      {
        name: "S. Bro",
        email: "bro@sbahj.info",
        phone_number: "5558018045"
      }
    end
    let(:bro_found) { Author.find_by(name: bro_attributes[:name]) }

    before { post :create, bro_attributes }

    it "creates successfully" do
      expect(bro_found).to be_a(Author)
    end

    it "redirects to show page" do
      expect(response).to redirect_to(author_path(bro_found))
    end
  end

  describe "creating an invalid author" do
    let(:bad_attributes) do
      {
        email: @author.email,
        phone_number: "555"
      }
    end

    before { @bad = Author.create(bad_attributes) }

    it "does not save" do
      expect(@bad).to be_new_record
    end

    it "does not create" do
      expect(Author.find_by(phone_number: bad_attributes[:phone_number])).to be_nil
    end

    it "has an error for missing name" do
      expect(@bad.errors[:name]).to_not be_empty
    end

    it "has an error for non-unique email" do
      expect(@bad.errors[:email]).to_not be_empty
    end

    it "has an error for too-short phone number" do
      expect(@bad.errors[:phone_number]).to_not be_empty
    end

    it "renders the form again" do
      post :create, bad_attributes
      expect(response).to render_template(:new)
    end
  end
end
