#!/usr/bin/env ruby

class ActionMan

	def initialize(album, data_dir)
		@album = album
		@DATA_DIR = data_dir
	end

	def make_search_phrase
		phrase = @album.gsub(DATE_REGEX,'').gsub(SYMBOLS_REGEX,'+').gsub(ADDITIONAL_PLUSES, '+').downcase
	end

	def execute_download
		phrase = make_search_phrase
		return "next" if data = JSONDataHandler.new(@DATA_DIR, phrase, @album).get_album == "next"	
	end
end