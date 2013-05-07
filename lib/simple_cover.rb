#!/usr/bin/env ruby

module SimpleCover

  def self.execute(args)
    case args[:action]
    when "standarize"
      Standarizer.new(args[:files]).standarize
    when "download_covers"
      CoverDownloader.new(args[:files]).download
    else
      raise InvalidCommandError, "Command: #{args[:action]} invalid"
    end
  end
end

class InvalidCommandError < Exception
  
end
