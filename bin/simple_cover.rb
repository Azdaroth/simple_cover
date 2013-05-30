#!/usr/bin/env ruby

require 'rubygems'
require 'rest-client'
require 'crack'
require_relative '../lib/simple_cover'


def files
  dir = Dir.pwd
  Dir.open(dir).select {|x| x != "." and x != ".." }
end


SimpleCover.execute(action: ARGV[0], files: files)




