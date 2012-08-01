$: << File.join(File.dirname(__FILE__), "/../lib")
require 'rubygems'
require 'rspec'
require 'simple_cover/simple_cover.rb'

# describe SimpleCover do
# 	context "giving input" do
# 		it "should call get_covers when input is get_covers all pwd" do
# 			simple_cover = SimpleCover.new
# 			input = mock('input').as_null_object
# 			STDOUT.should_receive(input).with("get_all_covers").and_return(get_covers)
# 		end
# 	end
# end