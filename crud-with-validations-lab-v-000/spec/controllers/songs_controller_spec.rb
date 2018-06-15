require 'rails_helper'

RSpec.describe SongsController, type: :controller do
  let(:valid_attributes) do
    {
      title: "Talisman",
      artist_name: "Air",
      release_year: 2007,
      released: true,
      genre: "Post-Rock"
    }
  end

  let(:invalid_attributes) do
    {
      title: nil,
      artist_name: nil,
      release_year: nil,
      released: true
    }
  end

  describe "basic listing, viewing and editing" do
    let(:song) { Song.create!(valid_attributes) }

    it "lists all songs" do
      get :index
      expect(assigns(:songs)).to eq([song])
    end

    it "views a single song" do
      get :show, { id: song.id }
      expect(assigns(:song)).to eq(song)
    end

    it "fetches a song for editing" do
      get :edit, { id: song.id }
      expect(assigns(:song)).to eq(song)
    end
  end

  context "creating a valid song" do
    before { post(:create, { song: valid_attributes }) }

    it "creates a new Song" do
      expect(Song.count).to eq(1)
    end

    it "assigns and persists new song" do
      expect(assigns(:song)).to be_a(Song)
      expect(assigns(:song)).to be_persisted
    end

    it "redirects to the created song" do
      expect(response).to redirect_to(Song.last)
    end
  end

  context "creating an invalid song" do
    before { post(:create, { song: invalid_attributes}) }

    it "has not been persisted" do
      expect(assigns(:song)).to be_new_record
    end

    it "re-renders the template" do
      expect(response).to render_template("new")
    end
  end

  context "updating a song with valid data" do
    let(:new_attributes) do
      { title: "Moon Safari" }
    end
    let(:song) { Song.create!(valid_attributes) }

    before do
      patch :update, { id: song.id, song: new_attributes }
    end

    it "updates the song" do
      song.reload
      expect(song.title).to eq("Moon Safari")
    end

    it "redirects to the song" do
      expect(response).to redirect_to(song)
    end
  end

  context "updating a song with invalid data" do
    let(:song) { Song.create!(valid_attributes) }
    before do
      patch :update, { id: song.id, song: invalid_attributes }
    end

    it "does not persist changes" do
      expect(song.title).to eq("Talisman")
    end

    it "re-renders the 'edit' template" do
      expect(response).to render_template("edit")
    end
  end

  context "destroying a song" do
    let(:song) { Song.create!(valid_attributes) }
    before do
      delete :destroy, { id: song.id }
    end

    it "destroys the requested song" do
      expect(Song.count).to eq(0)
    end

    it "redirects to the songs list" do
      expect(response).to redirect_to(songs_url)
    end
  end

end
