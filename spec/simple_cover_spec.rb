$: << File.join(File.dirname(__FILE__), "/../lib")
require 'rubygems'
require 'rspec'
require_relative '../lib/simple_cover'
require_relative '../lib/simple_cover/cover_downloader'
require_relative '../lib/simple_cover/standarizer'


describe SimpleCover do

  let(:dir) { stub }
  let(:runner) { SimpleCover }
  
  it "downloads covers" do
    cover_downloader = stub
    SimpleCover::CoverDownloader.should_receive(:new).with(dir) { cover_downloader }
    cover_downloader.should_receive(:download)
    runner.execute(action: 'download_covers', dir: dir)
  end

  it "standarizes names of albums" do
    standarizer = stub
    SimpleCover::Standarizer.should_receive(:new).with(dir) { standarizer }
    standarizer.should_receive(:standarize)
    runner.execute(action: 'standarize', dir: dir)
  end


  it "raises error when command is invalid" do
    runner = SimpleCover
    expect { runner.execute(action: "whatever") }.to raise_error InvalidCommandError
  end

end

