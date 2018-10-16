class Genre
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
    new = Genre.new(name)
    new.save
    new
  end
  
  def artists
    self.songs.map { |song| song.artist }.uniq
  end
end