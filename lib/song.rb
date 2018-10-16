require_relative 'artist'


class Song
  attr_accessor :name, :songs, :artist, :genre
  extend Concerns::Findable
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    @songs = []
    self.genre = genre if genre
    self.artist = artist if artist
    self.save
    
  end
  
  def self.all
    @@all
  end
  
  def save
    @@all << self unless @@all.include?(self) 
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(name, artist = nil, genre = nil)
    new = Song.new(name, artist = nil, genre = nil)
    new.save
    new
  end

  def genre=(genre)
    # new_genre = Genre.new(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
    # new_genre.songs
    
  end
  
  def artist=(artist)
    @artist =  artist #Artist.new(artist)
    artist.add_song(self)
  end
  
  def self.new_from_filename(filename)
      parts = filename.split(" - ")
      artist_str = parts[0]
      title_str = parts[1]
      genre_str = parts[2].split(".")[0]
      artist = Artist.find_or_create_by_name(artist_str)
      genre = Genre.find_or_create_by_name(genre_str)
      Song.new(title_str, artist, genre)
  end
  
  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end
end