#!/usr/bin/env ruby

class SimpleCover

	def initialize(welcome)
		@welcome = welcome
	end		

	def run
		puts "\n"
		puts @welcome, "\n"

		get_input
	end

	def get_input
		print "SimpleCover$ "
		input = gets.chomp
		choose_action(input)
	end

	def choose_action(input=ARGV[0])
		exits = ["quit", "exit", "q"]
		if input == "get_covers" 
			do_action("covers")
		elsif input == "standarize"
			do_action(input)
		elsif exits.include? input
			puts "\n", "Thank you for using Simple Cover"
			exit(0)
		elsif input == "help"
			help
		else
			puts "Command not found"
			# get_input
		end
	end

	def do_action(request)
		@DATA_DIR = `pwd`.chop
		Dir.open(@DATA_DIR).select {|x| x != "." and x != ".." }.each do |album|
			next if album == "simple_cover"
			action = ActionMan.new(album, @DATA_DIR)
			if request == "covers"		
				next if action.execute_download == "next"
			else
				next if action.standarize == "next"			
			end
		end
		puts "No more requests. Enjoy."
		# get_input
	end

	def help
		help_text = <<HELP
Change directory to the one with your music collection.
Type "get_covers" to download covers for all albums.
Type "standarize" to standarize folder names to band_name-album_name-release_year format
HELP

		puts help_text
		# get_input
	end
end