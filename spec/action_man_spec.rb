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

	context "making search phrase" do
		it "should return proper phrase" do
			validate_search_phrase(albums, expectations)
		end
	end

	context "making standarized name" do
		it "should return proper name" do
			name = "Cradle of Filth - Midian"
			year = 2000
			data = ActionMan.new("album", "directory").make_standarized_name(name, year)
			data.should == "cradle_of_filth-midian-2000"
		end
	end
end

