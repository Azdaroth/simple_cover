BASE_URL = "http://www.discogs.com"
BASE_API_DB_URL = "http://api.discogs.com/database/"
SEARCH_PHRASE = "search?q="
SEARCH_URL = BASE_API_DB_URL + SEARCH_PHRASE

DATE_REGEX = /(-\d+|(\d+)|_\d+)/
SYMBOLS_REGEX = /(-|:|\d+|;|_|\s+)/
ADDITIONAL_PLUSES = /\++/
SPACES_REGEX = /\s+/