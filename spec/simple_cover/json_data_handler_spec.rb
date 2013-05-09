require 'rubygems'
require 'spec_helper'
require 'rspec'
require 'simple_cover/json_data_handler'
require 'simple_cover/discogs_connecter'


describe SimpleCover::JSONDataHandler do

	let(:resource_not_found) { SimpleCover::JSONDataHandler::ResourceNotFound }

	describe "#get_album_url" do
		context "album is found" do
			it "returns album's resource url" do
				VCR.use_cassette "album_found" do
					search_phrase = "Cradle+Of+Filth+Midian"
					result = SimpleCover::JSONDataHandler.new(search_phrase).get_album_url
					result.should eq "http://api.discogs.com/releases/3422947"	
				end			
			end
		end

		context "and album is not found" do
			it "should return resource_not_found" do
				VCR.use_cassette "album_not_found" do
					search_phrase = "sdfklsdfls+sdflskdfjl"
					data = SimpleCover::JSONDataHandler.new(search_phrase)
					result = data.get_album_url
					result.should eq resource_not_found
				end			
			end	
		end
	end

	describe "#get_image" do
		context "image is found" do
			it "should return resource_not_found" do
				search_phrase = "Cradle+Of+Filth+Midian"
				data = SimpleCover::JSONDataHandler.new(search_phrase)
				data.stub(:images) { { "images" => [ { "uri" => "http://api.discogs.com/image/R-3422947-1329819090.jpeg" } ] } }
				data.get_image.should eq "http://api.discogs.com/image/R-3422947-1329819090.jpeg"
			end
		end

		context "image is not found" do
			it "returns resource_not_found" do
				VCR.use_cassette "album_not_found" do
					resource_url = "qwe+asde"
					data = SimpleCover::JSONDataHandler.new(resource_url).get_image
					data.should eq resource_not_found
				end	
			end
		end
	end

	describe "#get_release_info" do
		context "release info is found" do
			it "returns release info" do
				VCR.use_cassette "release_found" do
					search_phrase = "cradle+of+filth+midian"
					data = SimpleCover::JSONDataHandler.new(search_phrase)
					data.get_release_info.should == {"title" => "Cradle Of Filth - Midian", "year" => "2000"}
				end
			end
		end

		context "release info is not found" do
			it "returns resource_not_found" do
				VCR.use_cassette "release_not_found" do
					search_phrase = "qweqweqweqweqwe"
					data = SimpleCover::JSONDataHandler.new(search_phrase)
					data.get_release_info.should eq resource_not_found
				end
			end
		end
	end
end