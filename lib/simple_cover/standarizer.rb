require_relative 'album'
require_relative 'regex_handler'
require_relative 'filter'
require_relative 'discogs_connecter'
require_relative 'json_data_handler'

module SimpleCover
  class Standarizer
    
    attr_reader :json_data_handler, :regex_handler, :albums, :filter
    def initialize(files, args={})
      @albums = files.map { |dir| Album.convert(dir) }
      @json_data_handler = args.fetch(:json_data_handler, SimpleCover::JSONDataHandler)
      @regex_handler = args.fetch(:regex_handler , SimpleCover::RegexHandler)
      @filter = args.fetch(:filter, SimpleCover::Filter)
    end

    def standarize
      filtered_albums(albums).each do |album|
        json = json_data_handler.new(album.search_phrase)
        if (title_data = json.get_release_info) == SimpleCover::JSONDataHandler::ResourceNotFound
          return "ResourceNotFound - #{album.name} skipped"
        else
          name = title_data['title']
          year = title_data['year']
          standarized_name = regex_handler.make_standarized_name(name, year)
          FileUtils.move(album.path, current_dir + "/" + standarized_name)
          sleep 1.0
          puts "Waiting 1 second for the next request"
        end
      end
    end

    private

      def current_dir
        Dir.pwd
      end

      def filtered_albums(albums)
        filter.new(albums).reject_by(:standarized?)
      end

  end
end
