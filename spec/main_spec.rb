$: << File.join(File.dirname(__FILE__), "/../lib")
require 'rubygems'
require 'rspec'
require_relative '../lib/simple_cover/main.rb'


describe Main do
  
  it "runs proper app part based on passed arguments" do
    pwd = stub
    standarizer = Standarizer.new(pwd)
    cover_downaloader = CoverDownloader.new(pwd)
    runner = Main.new(actions: ['standarize', 'download_covers'],
                              standarizer: standarizer, cover_downloader: cover_downaloader)
    standarizer.should_receive(:standarize)
    cover_downaloader.should_receive(:download)
    runner.execute
  end

  it "raises error when command is invalid" do
    runner = Main.new(actions: ['whatever'])
    expect { runner.execute }.to raise_error InvalidCommandError
  end

end

class Standarizer
  
  def initialize(directory)
    @directory = directory
  end

  def standarize
    
  end

end

class CoverDownloader
  
  def initialize(directory)
    @directory = directory
  end

  def download
    
  end

end