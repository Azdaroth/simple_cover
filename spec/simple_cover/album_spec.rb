require 'spec_helper'
require 'simple_cover/album'

describe SimpleCover::Album do

  it "converts to album object from directories" do
    expect(SimpleCover::Album.convert("whatever")).to be_instance_of SimpleCover::Album
  end
  
end