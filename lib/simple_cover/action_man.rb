#!/usr/bin/env ruby

class ActionMan

	def initialize(album, data_dir)
		@album = album
		@DATA_DIR = data_dir
	end

	def make_search_phrase
		phrase = @album.gsub(DATE_REGEX,'').gsub(SYMBOLS_REGEX,'+').gsub(ADDITIONAL_PLUSES, '+').downcase
	end

	def make_standarized_name(name, year)
		standarized_name = "#{name}-#{year}".gsub(SPACES_REGEX,'_').gsub('_-_','-').downcase
	end

	def execute_download
		phrase = make_search_phrase
		data = JSONDataHandler.new(phrase)
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

	def standarize
		phrase = make_search_phrase
		puts "Changing name for #{@album}"
		if JSONDataHandler.new(phrase).get_release_info == "next"
			return "next"
		else
			info = JSONDataHandler.new(phrase).get_release_info
			name = info['title']
			year = info['year']
			standarized_name = make_standarized_name(name, year)
			current_dir = (Dir.pwd+"/"+@album).gsub("\"","'")
			new_dir = (Dir.pwd+"/"+standarized_name).gsub("\"","'")
			if new_dir != current_dir
				FileUtils.mv(current_dir, new_dir)
				puts "Standarized"
			else
				puts "Already standarized"
			end
		end
	end
end