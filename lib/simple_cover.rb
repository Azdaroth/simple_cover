#!/usr/bin/env ruby
require_relative 'simple_cover/cover_downloader'
require_relative 'simple_cover/standarizer'


module SimpleCover

  def self.execute(args)
    case args[:action]
    when "standarize"
      Standarizer.new(args[:files]).standarize
    when "download_covers"
      CoverDownloader.new(args[:files]).download
    else
      raise InvalidCommandError, "Command: #{args[:action]} invalid, use: standarize or download_covers"
    end
  end
end

class InvalidCommandError < Exception  
end
