class AddArtistToSong < ActiveRecord::Migration
  def change
    add_reference :songs, :artist, index: true, foreign_key: true
  end
end
