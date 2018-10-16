require 'pry'
class MusicLibraryController
  attr_accessor :importer
  
  def initialize(path = "./db/mp3s")
    @importer = MusicImporter.new(path)
    importer.import
  end
  
  def call
    input = nil
    until input == 'exit'
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.strip
    end
  end
  
  def list_songs
    sorted = Song.all.sort_by { |song| song.name }
    sorted.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    sorted = Artist.all.sort_by { |artist| artist.name }
    sorted.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist.name}"
    end
  end
  
  def list_genres
    sorted = Genre.all.sort_by { |genre| genre.name }
    sorted.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if Artist.find_by_name(input)
      discography = Artist.find_by_name(input).songs
    else
      return
    end
    sorted = discography.sort_by { |song| song.name }
    sorted.each_with_index do |song, index|
      puts "#{index + 1}. #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    genres = Genre.all
    if genres.select { |genre| genre.name == input }.empty?
        return
      else
      selected = genres.select { |genre| genre.name == input }
      selected.each_with_index do |genre|
        sorted_songs = genre.songs.sort_by { |song| song.name }
        sorted_songs.each_with_index do |song, index|
          puts "#{index + 1}. #{song.artist.name} - #{song.name}"
        end
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i - 1
    list_songs.each_with_index do |song, index|
      p index
      # binding.pry
    end
  end
end