#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'restclient'
require 'awesome_print'
require 'crack'
require_relative 'json_data_handler'
require_relative 'action_man'

BASE_URL = "http://www.discogs.com"
BASE_API_DB_URL = "http://api.discogs.com/database/"
SEARCH_PHRASE = "search?q="
SEARCH_URL = BASE_API_DB_URL + SEARCH_PHRASE

DATE_REGEX = /(-\d+|(\d+)|_\d+)/
SYMBOLS_REGEX = /(-|:|\d+|;|_|\s+)/
ADDITIONAL_PLUSES = /\++/

class SimpleCover

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
		if @input == "get_covers all pwd"
			get_covers
		elsif exits.include? @input
			puts "\n", "Thank you for using Simple Cover"
			exit(0)
		elsif @input == "help"
			help
		else
			puts "Command not found"
			get_input
		end
	end

	def get_covers
		#@DATA_DIR = @input.split(' ')[-1]
		@DATA_DIR = `pwd`.chop
		Dir.open(@DATA_DIR).select {|x| x != "." and x != ".." }.each do |album|		
			next if action = ActionMan.new(album, @DATA_DIR).execute_download == "next"
		end
		puts "No more requests. Enjoy your covers."
		get_input
	end

	def help
		help_text = <<HELP
Change directory to the one with your music collection.
Type "get_covers all pwd" to download covers for all albums.
Type "get_covers scan pwd" to download covers for the albums that don't cover yet.
Type "q", "exit" or "quit" to exit Simple Cover 
HELP

		puts help_text, "\n"
		get_input
	end
end

SimpleCover.new.run





