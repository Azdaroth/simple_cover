require 'simple_cover/discogs_connecter'
require 'simple_cover/years_getter'

module SimpleCover
	class JSONDataHandler
		
		ResourceNotFound = Class.new

		def initialize(phrase)
			@connecter = SimpleCover::DiscogsConnecter.new(phrase)
		end

		def get_album_url
			begin
				resource_url = data[0]['resource_url']
			rescue 
				puts "Album not found in Discogs database"
				ResourceNotFound
			end
		end

		def get_image
			begin
				image_uri = images['images'][0]['uri']
			rescue 
				puts "Image not found in Discogs database"
				ResourceNotFound
			end
		end

		def get_release_info
			begin
				info = {"title" => data[0]['title'], "year" => get_proper_year }
			rescue
				puts "No information found"
				ResourceNotFound
			end
		end

	private

		def data
			@connecter.data_to_json['results']
		end

		def get_proper_year
			YearsGetter.new(data).most_common
		end

		def images
			SimpleCover::DiscogsConnecter.json_from_url(get_album_url)
		end
	end
end