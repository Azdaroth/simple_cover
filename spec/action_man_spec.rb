require 'rubygems'
require 'spec_helper'
require 'rspec'
require 'crack'
require 'restclient'
require 'simple_cover/action_man.rb'
require 'simple_cover/constants.rb'

describe ActionMan do

	let(:albums) { ["cradle_of_filth-midian-2001",
			 "Dimmu Borgir - 2001_Puritanical_Euphoric_Misanthropia"] }
	let(:expectations) { ["cradle+of+filth+midian", 
				"dimmu+borgir+puritanical+euphoric+misanthropia"] }

	context "#make_search_phrase" do
		it "returns proper phrase" do
			(0..albums.length-1).each do |album_number|
				action = ActionMan.new(albums[album_number], "directory")
				action.make_search_phrase.should == expectations[album_number]
			end
		end
	end

	context "#make_standarized_name" do
		it "returns standarized name" do
			name = "Cradle of Filth - Midian"
			year = 2000
			data = ActionMan.new("album", "directory").make_standarized_name(name, year)
			data.should == "cradle_of_filth-midian-2000"
		end
	end
end

