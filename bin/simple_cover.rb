#!/usr/bin/env ruby

require 'rubygems'
require 'rest-client'
require 'crack'
require 'fileutils'
require_relative '../lib/simple_cover/simple_cover'
require_relative '../lib/simple_cover/json_data_handler'
require_relative '../lib/simple_cover/action_man'
require_relative '../lib/simple_cover/constants'


SimpleCover.new(welcome).choose_action





