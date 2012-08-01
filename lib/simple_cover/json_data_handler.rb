#!/usr/bin/env ruby

class JSONDataHandler
	
	def initialize(data_dir, phrase, album)
		@DATA_DIR = data_dir
		@phrase = phrase
		@album = album
	end

	def get_album
		resp = RestClient.get("#{SEARCH_URL}#{@phrase}", 'User-Agent' => 'Ruby')
		json_data = Crack::JSON.parse(resp)

		begin
			resource_url = json_data['results'][0]['resource_url']
		rescue Exception => error
			puts "album not found in Discogs database"
			return "next"
		end
		resource_url
	end

	def get_image(resource_url)
		release_resp = RestClient.get("#{resource_url}", 'User-Agent' => 'Ruby')
		json_release = Crack::JSON.parse(release_resp)

		begin
			image_uri = json_release['images'][0]['uri']
		rescue Exception => error
			puts "image not found in Discogs database"
			return "next"
		end
		image_uri
	end
end
