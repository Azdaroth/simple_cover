#!/usr/bin/env ruby

class SimpleCover

	def initialize(welcome)
		@welcome = welcome
	end		

	def choose_action(input=ARGV[0])
		if input == "get_covers" 
			do_action("covers")
		elsif input == "standarize"
			do_action(input)
		else
			puts "Command not found"
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
	end
end