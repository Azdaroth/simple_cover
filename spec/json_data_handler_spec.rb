require 'rubygems'
require 'spec_helper'
require 'rspec'
require 'crack'
require 'restclient'
require 'simple_cover/json_data_handler.rb'
require 'simple_cover/constants.rb'

describe JSONDataHandler do
	describe "when getting an album" do
		context "and album is found" do
			it "should return album's resource url" do
				VCR.use_cassette "album_found" do
					search_phrase = "Cradle+Of+Filth+Midian"
					data = JSONDataHandler.new(search_phrase)
					result = data.get_album
					result.should == "http://api.discogs.com/releases/3422947"	
				end			
			end
		end

		context "and album is not found" do
			it "should return string 'next'" do
				VCR.use_cassette "album_not_found" do
					search_phrase = "sdfklsdfls+sdflskdfjl"
					data = JSONDataHandler.new(search_phrase)
					result = data.get_album
					result.should == "next"
				end			
			end	
		end
	end

	describe "when getting an image" do
		context "and image is found" do
			it "should return image uri" do
				VCR.use_cassette "image_found" do
					resource_url = "http://api.discogs.com/releases/3422947"
					data = JSONDataHandler.new("phrase").get_image(resource_url)
					data.should == 	"http://api.discogs.com/image/R-3422947-1329819090.jpeg"
				end	
			end
		end

		context "and image is not found" do
			it "should return string 'next'" do
				VCR.use_cassette "image_not_found" do
					resource_url = "http://api.discogs.com/releases/qwerty12345"
					data = JSONDataHandler.new("phrase").get_image(resource_url)
					data.should == "next"
				end	
			end
		end
	end

	describe "when getting release info" do
		context "and release info is found" do
			it "should return release info" do
				VCR.use_cassette "relsease_found" do
					search_phrase = "cradle+of+filth+midian"
					data = JSONDataHandler.new(search_phrase)
					data.get_release_info.should == {"title" => "Cradle Of Filth - Midian", "year" => "2000"}
				end
			end
		end

		context "and release info is not found" do
			it "should return string 'next'" do
				VCR.use_cassette "relsease_not_found" do
					search_phrase = "qwerty+123+random+stuff"
					data = JSONDataHandler.new(search_phrase)
					data.get_release_info.should == "next"
				end
			end
		end
	end

	describe "when getting proper year" do
		it "should return the most common year" do
			VCR.use_cassette "proper_year" do
				search_phrase = "cradle+of+filth+midian"
				data = JSONDataHandler.new(search_phrase)
				results = Crack::JSON.parse(RestClient.get("#{SEARCH_URL}#{search_phrase}", 'User-Agent' => 'Ruby'))['results']
				data.get_proper_year(results).should == "2000"
			end
		end
	end
end