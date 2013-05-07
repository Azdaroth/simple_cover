$: << File.join(File.dirname(__FILE__), "/../lib")
require 'rubygems'
require 'rspec'
require_relative '../lib/simple_cover'
require_relative '../lib/simple_cover/cover_downloader'
require_relative '../lib/simple_cover/standarizer'


describe SimpleCover do

  let(:files) { stub }
  let(:runner) { SimpleCover }
  
  it "downloads covers" do
    cover_downloader = stub
    SimpleCover::CoverDownloader.should_receive(:new).with(files) { cover_downloader }
    cover_downloader.should_receive(:download)
    runner.execute(action: 'download_covers', files: files)
  end

  it "standarizes names of albums" do
    standarizer = stub
    SimpleCover::Standarizer.should_receive(:new).with(files) { standarizer }
    standarizer.should_receive(:standarize)
    runner.execute(action: 'standarize', files: files)
  end


  it "raises error when command is invalid" do
    runner = SimpleCover
    expect { runner.execute(action: "whatever") }.to raise_error InvalidCommandError
  end

end

