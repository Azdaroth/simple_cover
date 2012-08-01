#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'restclient'
require 'awesome_print'
require 'crack'
require_relative '../lib/simple_cover/simple_cover'
require_relative '../lib/simple_cover/json_data_handler'
require_relative '../lib/simple_cover/action_man'

BASE_URL = "http://www.discogs.com"
BASE_API_DB_URL = "http://api.discogs.com/database/"
SEARCH_PHRASE = "search?q="
SEARCH_URL = BASE_API_DB_URL + SEARCH_PHRASE

DATE_REGEX = /(-\d+|(\d+)|_\d+)/
SYMBOLS_REGEX = /(-|:|\d+|;|_|\s+)/
ADDITIONAL_PLUSES = /\++/

welcome = <<WELCOME
Welcome to Simple Cover interface.
This simple app can download covers for all albums or the ones specyfied by input.
You can also standarize your folder names.
Type "help" to check all the commands and get more information.
Keep in mind that you can only make 1000 request per 24 hours as it is based on the Discogs API.
WELCOME

SimpleCover.new.run(welcome)





