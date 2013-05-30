require 'rubygems'
require 'spec_helper'
require 'rspec'
require 'simple_cover/filter'

describe SimpleCover::Filter do
  
  it "rejects collection elements by checking specified condition" do
    el_1 = stub(ok?: true)
    el_2 = stub(ok?: false)
    collection = [el_1, el_2]
    expect(SimpleCover::Filter.new(collection).reject_by(:ok?)).to eq [el_2]
  end

end