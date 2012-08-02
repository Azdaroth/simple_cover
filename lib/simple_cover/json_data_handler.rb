#!/usr/bin/env ruby

class JSONDataHandler
	
	def initialize(phrase)
		@phrase = phrase
	end

	def get_album
		resp = RestClient.get("#{SEARCH_URL}#{@phrase}", 'User-Agent' => 'Ruby')
		json_data = Crack::JSON.parse(resp)

		begin
			resource_url = json_data['results'][0]['resource_url']
		rescue Exception => error
			puts "Album not found in Discogs database"
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
			puts "Image not found in Discogs database"
			return "next"
		end
		image_uri
	end

	def get_release_info
		resp = RestClient.get("#{SEARCH_URL}#{@phrase}", 'User-Agent' => 'Ruby')
		json_data = Crack::JSON.parse(resp)

		begin
			info = {"title" => json_data['results'][0]['title'], 
				"year" => get_proper_year(json_data['results']) }
		rescue Exception => error
			puts "No information found"
			return "next"
		end
		
		info
	end

	def get_proper_year(results)
		years = []
		results.each { |result| years << result["year"] }
		proper_year = years.group_by { |x| x }.to_a.map { |y| y.flatten }.sort_by { |z| z.length }[-1][0] 
	end
end
