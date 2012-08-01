require 'rubygems'
require 'nokogiri'
require 'restclient'
require 'awesome_print'
require 'crack'

class SimpleCover

	BASE_URL = "http://www.discogs.com"
	BASE_API_DB_URL = "http://api.discogs.com/database/"
	SEARCH_PHRASE = "search?q="
	SEARCH_URL = BASE_API_DB_URL + SEARCH_PHRASE

	def initialize

		@welcome = <<WELCOME
Welcome to Simple Cover interface.
This simple app can download covers for all albums or the ones specyfied by input.
You can also standarize your folder names.
Type "help" to check all the commands and get more information.
Keep in mind that you can only make 1000 request per 24 hours as it is based on the Discogs API.
WELCOME

	end		

	def run
		puts "\n"
		puts @welcome, "\n"

		get_input
	end

	def get_input
		print "wat'cha wanna do? $ "
		@input = gets.chomp	
		exits = ["quit", "exit", "q"]
		if @input.split(' ').include? "get_covers" and "all" and @input.split.length == 3
			get_covers
		elsif exits.include? @input
			puts "\n", "Thank you for using Simple Cover"
			exit(0)
		else
			puts "Command not found"
			get_input
		end
	end

	def get_covers
		@DATA_DIR = @input.split(' ')[-1]
		Dir.open(@DATA_DIR).select {|x| x != "." and x != ".." }.each do |album|
			action = ActionMan.new(album)
			action.make_phrase
			action.execute_download
			next if data = JSONDataHandler.new(@DATA_DIR, SEARCH_URL, phrase, album).get_cover == "next"
		end
		puts "No more requests. Enjoy your covers."
		get_input
	end
end

class JSONDataHandler
	
	def initialize(data_dir, search_url, phrase, album)
		@DATA_DIR = data_dir
		@SEARCH_URL = search_url
		@phrase = phrase
		@album = album
	end

	def get_album
		resp = RestClient.get("#{@SEARCH_URL}#{@phrase}", 'User-Agent' => 'Ruby')
		json_data = Crack::JSON.parse(resp)

		begin
			resource_url = json_data['results'][0]['resource_url']
		rescue Exception => error
			puts "album not found in Discogs database"
			return "next"
		else
			get_image(resource_url)
		end
	end

	def get_image(resource_url)
		release_resp = RestClient.get("#{resource_url}", 'User-Agent' => 'Ruby')
		json_release = Crack::JSON.parse(release_resp)

		begin
			image_uri = json_release['images'][0]['uri']
		rescue Exception => error
			puts "image not found in Discogs database"
		else
			File.open("#{@DATA_DIR}/#{@album}/cover.jpg", 'w') { |f| f.write(RestClient.get(image_uri)) }
		ensure
			sleep 1.0
			puts "Waiting 1 second for the next request"
		end
	end
end

class ActionMan

	def initialize(album)
		@album = album
	end

	def make_search_phrase
		DATE_REGEX = /(-\d+|(\d+)|_\d+)/
		SYMBOLS_REGEX = /(-|:|\d+|;|_|\s+)/
		ADDITIONAL_PLUSES = /\++/

		@phrase = album.gsub(DATE_REGEX,'').gsub(SYMBOLS_REGEX,'+').gsub(ADDITIONAL_PLUSES, '+').downcase
	end

	def execute_download
		
	end
end

# puts "\n"

# welcome = <<WELCOME
# Welcome to Simple Cover.
# This simple app can download covers for all albums or the ones specyfied by input.
# You can also standarize your folder names.
# Type "help" to check all the commands and get more information.
# Keep in mind that you can only make 1000 request per 24 hours as it is based on the Discogs API.
# WELCOME

# puts welcome, "\n"

# print "wat'cha wanna do? $ "
# input = gets.chomp

# BASE_URL = "http://www.discogs.com"
# BASE_API_DB_URL = "http://api.discogs.com/database/"
# SEARCH_PHRASE = "search?q="
# SEARCH_URL = BASE_API_DB_URL + SEARCH_PHRASE

# DATE_REGEX = /(-\d+|(\d+)|_\d+)/
# SYMBOLS_REGEX = /(-|:|\d+|;|_|\s+)/
# ADDITIONAL_PLUSES = /\++/

# DATA_DIR = "/home/azdaroth/Desktop/folders_for_covers"

# Dir.open(DATA_DIR).select {|x| x != "." and x != ".." }.each do |album|
# 	phrase = album.gsub(DATE_REGEX,'').gsub(SYMBOLS_REGEX,'+').gsub(ADDITIONAL_PLUSES, '+').downcase
# 	puts "Now searching for #{album} cover", "\n"

# 	resp = RestClient.get("#{SEARCH_URL}#{phrase}", 'User-Agent' => 'Ruby')
# 	json_data = Crack::JSON.parse(resp)

# 	begin
# 		resource_url = json_data['results'][0]['resource_url']
# 	rescue Exception => error
# 		puts "album not found in Discogs database"
# 		next
# 	end
	
# 	release_resp = RestClient.get("#{resource_url}", 'User-Agent' => 'Ruby')
# 	json_release = Crack::JSON.parse(release_resp)

# 	begin
# 		image_uri = json_release['images'][0]['uri']
# 	rescue Exception => error
# 		puts "image not found in Discogs database"
# 	else
# 		File.open("#{DATA_DIR}/#{album}/cover.jpg", 'w') { |f| f.write(RestClient.get(image_uri)) }
# 	ensure
# 		sleep 1.0
# 		puts "Waiting 1 second for the next request"
# 	end
# end
# puts "No more requests. Enjoy your covers."

START = SimpleCover.new.run





