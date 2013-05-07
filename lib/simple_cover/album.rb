module SimpleCover
  class Album

    attr_accessor :name, :year    
    def self.convert(name)
      new(name)
      @json_data_handler = SimpleCover::JSONDataHandler.new(name)
    end

    def initialize(name)
      @name = name
    end


    def has_cover?
      
    end

    def is_standarized?
      
    end

  end
end