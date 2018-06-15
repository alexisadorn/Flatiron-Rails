describe "songs", type:  :feature do

  before do
    Artist.destroy_all
    Song.destroy_all
    @artist = Artist.create!(name: "Daft Punk")
    @song = @artist.songs.create!(title: "The Grid")
  end

  context "when nested under artists" do
    describe "/artists/:artist_id/songs" do
      it "displays the songs with valid artist" do
        visit artist_songs_path(@artist)
        expect(page).to have_text(@song.title)
      end

      it "redirects to /artists with invalid artist" do
        visit artist_songs_path(1234)
        expect(page).to have_link(@artist.name, href: artist_songs_path(@artist))
        expect(page).to have_text("Artist not found")
      end
    end

    describe "/artists/:artist_id/songs/:id" do
      it "displays the song" do
        visit artist_song_path(@artist, @song)
        expect(page).to have_text(@song.title)
      end

      it "redirects to /artists/id/songs with invalid song" do
        visit artist_song_path(@artist, 1232)
        expect(page).to have_link(@song.title, href: song_path(@song))
        expect(page).to have_text("Song not found")
      end
    end
  end
  describe "/songs/:id" do

    it "links to the artist" do
      visit song_path(@song)
      expect(page).to have_link("Daft Punk", href: artist_path(@artist))
    end

    it "links to edit when no artist" do
      song = Song.create(title: "Policy of Truth")
      visit song_path(song)
      expect(page).to have_link("Add Artist", href: edit_song_path(song))
    end

  end

  describe "/songs" do

    it "links to the song" do
      visit songs_path
      expect(page).to have_link("The Grid", href: song_path(@song))
    end

    it "has a link to edit the song if no artist" do
      song = Song.create(title: "Mambo No. 5")
      visit songs_path
      expect(page).to have_link("Add Artist", href: edit_song_path(song))
    end

  end
end
