require 'simple_cover/json_data_handler'
module SimpleCover
  class Album
 
    def self.convert(name)
      new(name)
    end

    attr_accessor :name, :year   
    def initialize(name)
      @name = name
      @json_data_handler = SimpleCover::JSONDataHandler.new(name)
    end

    def has_cover?
            
    end

    def is_standarized?
      SimpleCover::RegexHandler.standarized?(name)
    end

  end
end