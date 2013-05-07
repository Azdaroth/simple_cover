#!/usr/bin/env ruby

require 'rubygems'
require 'rest-client'
require 'crack'
require_relative '../lib/simple_cover'


SimpleCover.execute(action: ARGV[0], files: files)

def files
  dir = `pwd`.chop
  Dir.open(dir).select {|x| x != "." and x != ".." }
end





