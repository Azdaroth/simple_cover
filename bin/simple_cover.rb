#!/usr/bin/env ruby

require 'rubygems'
require 'rest-client'
require 'crack'
require_relative '../lib/simple_cover/main'
require_relative '../lib/simple_cover/json_data_handler'
require_relative '../lib/simple_cover/action_man'
require_relative '../lib/simple_cover/constants'


runner = Main.new(actions: ARGV, standarizer: Standarizer.new(current_dir),
         cover_downloader: CoverDownloader.new(current_dir))
runner.execute


def current_dir
  `pwd`.chop
end





