require_relative '../spec_helper'
require_relative '../../lib/simple_cover/regex_handler'

describe SimpleCover::RegexHandler do


  let(:albums) { ["cradle_of_filth-midian-2001",
       "Dimmu Borgir - 2001_Puritanical_Euphoric_Misanthropia"] }
  let(:expectations) { ["cradle+of+filth+midian", 
        "dimmu+borgir+puritanical+euphoric+misanthropia"] }

  it "#makes search phrase" do
    (0..albums.length-1).each do |idx|
      expect(SimpleCover::RegexHandler.make_search_phrase(albums[idx])).to eq expectations[idx]
    end
  end

  it "makes standarized_name" do
    name = "Cradle of Filth - Midian"
    year = 2000
    data = SimpleCover::RegexHandler.make_standarized_name(name, year)
    expect(data).to eq "cradle_of_filth-midian-2000"
  end

  context "standarized?" do
    it "returns true if name is standarized" do
      expect(SimpleCover::RegexHandler.standarized?("cradle_of_filth-midian-2000")).to be true
    end

    it "returns false if name is not standarized" do
      expect(SimpleCover::RegexHandler.standarized?("Dimmu Borgir - 2001_Puritanical_Euphoric_Misanthropia")).to be false
    end
  end

end