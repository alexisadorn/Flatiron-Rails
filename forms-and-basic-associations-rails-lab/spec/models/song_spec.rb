require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'genre_name=' do
    it 'sets the genre to the genre of the specified name' do
      song = Song.new
      song.genre_name = 'Rock'
      expect(song.genre.name).to eq 'Rock'
    end
  end

  describe 'genre_name' do
    it 'returns the genre name' do
      song = Song.new
      song.genre_name = 'Rock'
      expect(song.genre_name).to eq 'Rock'
    end
  end

  describe 'artist_name=' do
    it 'sets the artist to the artist of the specified name' do
      song = Song.new
      song.artist_name = 'Rock Hudson'
      expect(song.artist.name).to eq 'Rock Hudson'
    end
  end

  describe 'artist_name' do
    it 'returns the artist name' do
      song = Song.new
      song.artist_name = 'Rock Hudson'
      expect(song.artist_name).to eq 'Rock Hudson'
    end
  end

  describe 'note_contents' do
    it 'returns the content of all notes as an array' do
      song = Song.new
      song.note_contents = ['hi', 'there']
      expect(song.note_contents).to eq ['hi', 'there']
    end
  end

  describe 'note_contents=' do
    it 'sets notes for a song' do
      song = Song.new
      notes = ['Great song', 'much bass', 'wow']
      song.note_contents = notes
      expect(song.notes.map(&:content)).to eq notes
    end
    it 'adds to existing notes' do
      song = Song.new
      notes = ['Great song']
      song.note_contents = ['Great song']
      expect(song.notes.map(&:content)).to eq notes
      notes << 'much bass'
      song.note_contents = ['much bass']
      expect(song.notes.map(&:content)).to eq notes
      notes << 'wow'
      song.note_contents = ['wow']
      expect(song.notes.map(&:content)).to eq notes
    end
    it 'ignores blank notes' do
      song = Song.new
      song.note_contents = ['', "i'm all alone", '', '']
      expect(song.note_contents).to eq ["i'm all alone"]
    end
  end

end
