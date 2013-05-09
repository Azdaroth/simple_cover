module SimpleCover
  class CoverDownloader
    
    attr_reader :json_data_handler
    def initialize(files)
      @files = files
      @json_data_handler = JSONDataHandler
    end

    def download
      
    end

  end
end



# data = JSONDataHandler.new(phrase)
#       if data.get_album == "next"
#         return "next" 
#       else
#         puts "Downloading cover for #{@album}"
#         resource_url = data.get_album
#         if data.get_image(resource_url) == "next"
#           return "next"
#         else
#           image_uri = data.get_image(resource_url)  
#           save_image(image_uri)   
#         end
#       end