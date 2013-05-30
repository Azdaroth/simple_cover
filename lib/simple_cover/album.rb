require_relative 'json_data_handler'
require_relative 'regex_handler'
module SimpleCover
  class Album
 
    def self.convert(name)
      new(name)
    end

    attr_accessor :name, :regex_handler   
    def initialize(name, regex_handler = SimpleCover::RegexHandler)
      @name = name
      @regex_handler = regex_handler
    end

    def path(wd=Dir.pwd)
      wd + "/" + name
    end

    def has_cover?(wd=Dir.pwd)
      Dir.new(wd + '/' + name).include? "cover.jpg"
    end

    def search_phrase
      regex_handler.make_search_phrase(name)
    end

    def standarized_name
      regex_handler.make_standarized_name(name)
    end

    def standarized?
      regex_handler.standarized?(name)
    end

  end
end