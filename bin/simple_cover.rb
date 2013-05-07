#!/usr/bin/env ruby

require 'rubygems'
require 'rest-client'
require 'crack'
require_relative '../lib/simple_cover'


SimpleCover.execute(action: ARGV[0], dir: current_dir)

def current_dir
  `pwd`.chop
end





