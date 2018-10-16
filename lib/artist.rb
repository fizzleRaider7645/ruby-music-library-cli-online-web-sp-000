class Artist
  attr_accessor :name, :songs
  
  extend Concerns::Findable 
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
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
  
  def self.create(name)
    new = Song.new(name)
    new.save
  end
  
  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.artist = self if song.artist.nil?
  end
  
  def self.create(name)
    new = Artist.new(name)
    new.save
    new
  end
  
  def genres
    self.songs.map { |song| song.genre }.uniq
  end
end