require 'rubygems'
require 'spec_helper'
require 'rspec'
require 'simple_cover/cover_downloader'

describe SimpleCover::CoverDownloader do

  let(:file) { "Therion-Lemuria" }
  let(:files) { [file] }
  let(:album) { SimpleCover::Album.new("Therion-Lemuria") }
  let(:filter) { stub(:filter) }
  let(:connecter) { stub(:connecter) }
  let(:json_data_handler) { stub(:json_data_handler) }

  before(:each) do
    SimpleCover::Album.stub(:convert).with(file) { album }
    filter.stub_chain(:new, :reject_by) { [album] }
    album.stub(:path) { "/path_to_album/Therion-Lemuria" }
  end

  it "download cover if image is found and album has not cover" do
    json = stub(:json)
    image = stub(:image) 
    album.stub(:has_image?) { false }
    json_data_handler.should_receive(:new) { json }
    json.stub(:get_image) { "image.jpg" }
    connecter.should_receive(:get_image).with("image.jpg") { image }
    File.should_receive(:open).with("#{album.path}/cover.jpg"  ,'w') { true }
    downloader = SimpleCover::CoverDownloader.new(files, json_data_handler: json_data_handler,
                   filter: filter, discogs_connecter: connecter)
    downloader.download
  end

  it "does not download cover if image is not found" do
    json = stub(:json)
    album.stub(:has_image?) { false }
    json_data_handler.should_receive(:new) { json }
    json.stub(:get_image) { SimpleCover::JSONDataHandler::ResourceNotFound }
    downloader = SimpleCover::CoverDownloader.new(files, json_data_handler: json_data_handler,
                   filter: filter, discogs_connecter: connecter)
    expect(downloader.download).to include "ResourceNotFound"
  end


  it "does not download cover if album already has cover" do
    filter.stub_chain(:new, :reject_by) { [] }
    File.should_not_receive(:open)
    downloader = SimpleCover::CoverDownloader.new(files, json_data_handler: json_data_handler,
                   filter: filter, discogs_connecter: connecter)
    downloader.download
  end
    
end