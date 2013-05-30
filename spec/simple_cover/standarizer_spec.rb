require 'rubygems'
require 'spec_helper'
require 'rspec'
require 'simple_cover/standarizer'
require 'simple_cover/album'

describe SimpleCover::Standarizer do

  let(:file) { "Therion-Lemuria" }
  let(:files) { [file] }
  let(:album) { SimpleCover::Album.new("Therion-Lemuria") }
  let(:filter) { stub(:filter) }
  let(:regex_handler) { stub(:regex_handler) }
  let(:json_data_handler) { stub(:json_data_handler) }

  before(:each) do
    SimpleCover::Album.stub(:convert).with(file) { album }
    filter.stub_chain(:new, :reject_by) { [album] }
    album.stub(:path) { "/path_to_album/Therion-Lemuria" }
    Dir.stub(:pwd) { "/path_to_album" }
  end

  it "standarizes names if resource is found and is not standarized" do
    json = stub(:json)
    album.stub(:standarized?) { false }
    json_data_handler.should_receive(:new) { json }
    json.stub(:get_release_info) { {"title" => "therion+lemuria", "year" => "2004"} }
    regex_handler.should_receive(:make_standarized_name).with("therion+lemuria", "2004") { "therion-lemuria-2004" }
    FileUtils.should_receive(:move).with(album.path, "/path_to_album/therion-lemuria-2004") { true }
    standarizer = SimpleCover::Standarizer.new(files, json_data_handler: json_data_handler,
                   filter: filter, regex_handler: regex_handler)
    standarizer.standarize
  end

  it "does not standarize if resource is not found" do
    json = stub(:json)
    album.stub(:standarized?) { false }
    json_data_handler.should_receive(:new) { json }
    json.stub(:get_release_info) { SimpleCover::JSONDataHandler::ResourceNotFound }
    standarizer = SimpleCover::Standarizer.new(files, json_data_handler: json_data_handler,
                   filter: filter, regex_handler: regex_handler)
    expect(standarizer.standarize).to include "ResourceNotFound"
  end


  it "does not standarize names if resource is found but already standarized" do
    filter.stub_chain(:new, :reject_by) { [] }
    FileUtils.should_not_receive(:move)
    standarizer = SimpleCover::Standarizer.new(files, json_data_handler: json_data_handler,
                   filter: filter, regex_handler: regex_handler)
    standarizer.standarize
  end
    
end