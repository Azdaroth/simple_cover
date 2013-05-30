require_relative 'album'
require_relative 'regex_handler'
require_relative 'filter'
require_relative 'discogs_connecter'
require_relative 'json_data_handler'

module SimpleCover
  class CoverDownloader
    
    attr_reader :json_data_handler, :albums, :connecter, :filter
    def initialize(files, args={})
      @albums = files.map { |dir| Album.convert(dir) }
      @json_data_handler = args.fetch(:json_data_handler, SimpleCover::JSONDataHandler)
      @connecter = args.fetch(:discogs_connecter, SimpleCover::DiscogsConnecter)
      @filter = args.fetch(:filter, SimpleCover::Filter)
    end

    def download
      filtered_albums(albums).each do |album|
        json = json_data_handler.new(album.search_phrase)
        if (img_url = json.get_image) == SimpleCover::JSONDataHandler::ResourceNotFound
          return "ResourceNotFound - #{album.name} skipped"
        else
          image = get_image(img_url)
          File.open("#{album.path}/cover.jpg", 'w') { |f| f.write(image) }
          sleep 1.0
          puts "Waiting 1 second for the next request"
        end
      end
    end


    private

      def filtered_albums(albums)
        filter.new(albums).reject_by(:has_cover?)
      end


      def get_image(img_url)
        connecter.get_image(img_url)
      end

  end
end