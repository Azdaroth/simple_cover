require 'rubygems'
require 'rest-client'
require 'crack'

module SimpleCover
  class DiscogsConnecter


    def self.json_from_url(url)
      resp = RestClient.get(url, 'User-Agent' => 'Ruby')
      Crack::JSON.parse(resp)
    end

    def self.get_image(url)
      RestClient.get(url)
    end

    
    def initialize(phrase)
      search_api_url = "http://api.discogs.com/database/search?q="
      @current_url = search_api_url + phrase
    end

    def data_to_json
      SimpleCover::DiscogsConnecter.json_from_url(@current_url)
    end

  end
end