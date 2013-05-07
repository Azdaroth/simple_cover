module SimpleCover
  class RegexHandler

    DATE_REGEX = /(-\d+|(\d+)|_\d+)/
    SYMBOLS_REGEX = /(-|:|\d+|;|_|\s+)/
    ADDITIONAL_PLUSES = /\++/
    SPACES_REGEX = /\s+/
    STANDARIZED_NAME = /[a-z0-9_.]+-[a-z0-9_.]+-[0-9]+/

    def self.make_search_phrase(name)
      name.gsub(DATE_REGEX,'').gsub(SYMBOLS_REGEX,'+').gsub(ADDITIONAL_PLUSES, '+').downcase
    end

    def self.make_standarized_name(name, year)
      "#{name}-#{year}".gsub(SPACES_REGEX,'_').gsub('_-_','-').downcase
    end

    def self.standarized?(name)
      STANDARIZED_NAME.match(name).to_s == name
    end
    
  end
end