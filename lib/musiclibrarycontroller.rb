require 'pry'

class MusicLibraryController
  attr_accessor :importer
  
  def initialize(path = "./db/mp3s")
    @importer = MusicImporter.new(path)
    importer.import
  end
  
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    until (input = gets.strip) == "exit"
      if input == "list songs"
        list_songs
      elsif input == "list artists"
        list_artists
      elsif input == "list genres"
        list_genres
      elsif input == "list artist"
        list_songs_by_artist
      elsif input == "list genre"
        list_songs_by_genre
      elsif input == "play song"
        play_song
      end
    end
  end
  
  def list_songs
    sorted = Song.all.sort_by { |song| song.name }
    sorted.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
    nil
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
    input = gets.strip.to_i
    song = Song.all.sort_by!{ |song| song.name }[input - 1] if input > 0 && input < Song.all.length
    puts "Playing #{song.name} by #{song.artist.name}" if song
  end
end