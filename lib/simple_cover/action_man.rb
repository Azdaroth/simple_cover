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
		data = JSONDataHandler.new(@DATA_DIR, phrase, @album)
		if data.get_album == "next"
			return "next" 
		else
			puts "Downloading cover for #{@album}"
			resource_url = data.get_album
			if data.get_image(resource_url) == "next"
				return "next"
			else
				image_uri = data.get_image(resource_url)	
				save_image(image_uri)		
			end
		end
	end

	def save_image(image_uri)
		File.open("#{@DATA_DIR}/#{@album}/cover.jpg", 'w') { |f| f.write(RestClient.get(image_uri)) }
		sleep 1.0
		puts "Waiting 1 second for the next request"
	end
end