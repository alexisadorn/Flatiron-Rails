require 'rails_helper'

RSpec.describe SongsController do

  before do
    Song.destroy_all
    Artist.destroy_all
    @artist = Artist.create(name: "Garth Brooks")
    @song = @artist.songs.create(title: "I'm def not Chris Gaines, Everyone haha what are you talking about?")
  end

  describe "GET new" do
    it "sets artist when nested route" do
      get :new, artist_id: @artist.id
      expect(assigns(:song).artist_id).to eq @artist.id
    end

    it "validates artist when nested route" do
      get :new, artist_id: 123123
      expect(response).to redirect_to artists_path
    end
  end

  describe "POST create" do
    it "accepts and sets artist_id" do
      post :create, song: {artist_id: @artist.id, title: "This is a test song!"}
      expect(Song.last.artist_id).to eq @artist.id
    end
  end

  describe "GET edit" do
    it "validates artist when nested" do
      get :edit, artist_id: 1234, id: @song.id
      expect(response).to redirect_to artists_path
    end

    it "validates song for artist when nested" do
      get :edit, artist_id: @artist.id, id: 1234
      expect(response).to redirect_to artist_songs_path(@artist)
    end
  end

  describe "GET index" do

    it "redirects when artist not found" do
      get :index, artist_id: "abc"
      expect(response).to redirect_to artists_path
    end

    it 'returns 200 when just index with no artist_id' do
      get :index
      expect(response).to be_ok
    end

  end

  describe "GET show with  artist" do

    it "returns 200 with valid song and no artist" do
      get :show, id: @song.id
      expect(response).to be_ok
    end

    it "redirects to artists songs when artist song not found" do
      get :show, id: 12345, artist_id: @artist.id
      expect(controller).to set_flash[:alert]
      expect(response).to redirect_to artist_songs_path(@artist)
    end

    it "returns 200 with valid artist song" do
      get :show, id: @song.id, artist_id: @artist.id
      expect(response).to be_ok
    end
  end

end
