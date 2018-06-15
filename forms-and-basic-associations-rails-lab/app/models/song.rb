class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    self.genre.name
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist.name
  end

  def note_contents=(notes)
    notes.each do |note|
      self.notes.build(content: note, song_id: self.id) unless note.blank?
    end
  end

  def note_contents
    note_contents = []
    self.notes.each do |note|
      note_contents << note.content
    end
    note_contents
  end
end
