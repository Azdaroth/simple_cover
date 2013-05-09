require 'rubygems'
require 'spec_helper'
require 'rspec'
require 'simple_cover/years_getter'


describe SimpleCover::YearsGetter do
  it "returns the most common year" do      
    years = [{"year" => "2000"}, {"year" => "2003"}, {"year" => "2002"}, {"year" => "2000"}, {"year" => "2001" }]
    getter = SimpleCover::YearsGetter.new(years)
    getter.most_common.should eq "2000"
  end
end