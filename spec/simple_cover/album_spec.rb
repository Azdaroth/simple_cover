require 'spec_helper'
require 'simple_cover/album'

describe SimpleCover::Album do

  it "converts to album object from directories" do
    expect(SimpleCover::Album.convert("whatever")).to be_instance_of SimpleCover::Album
  end

  it "verifies if name is standarized" do
    album  = SimpleCover::Album.new("Not Standarized")
    expect(album.standarized?).to be false
  end

  it "has current path" do
    dir = "/current_dir"
    album  = SimpleCover::Album.new("dimmu-borgir")
    expect(album.path(dir)).to eq "/current_dir/dimmu-borgir"
  end

  it "can be checked for having cover" do
    album_files = ["cover.jpg"]
    Dir.stub(:new) { album_files }
    album  = SimpleCover::Album.new("dimmu-borgir")
    expect(album.has_cover?).to be true
  end

  context "name related" do

    let(:regex_handler) { stub(:regex_handler) }
    let(:album) { SimpleCover::Album.new("dimmu-borgir", regex_handler) }

    it "has search phrase based on current name" do
      regex_handler.should_receive(:make_search_phrase).with("dimmu-borgir")
      album.search_phrase
    end

    it "has standarized based on current name" do
      regex_handler.should_receive(:make_standarized_name).with("dimmu-borgir")
      album.standarized_name
    end

    it "can be standarized" do
      regex_handler.should_receive(:standarized?).with("dimmu-borgir")
      album.standarized?
    end
  end
end