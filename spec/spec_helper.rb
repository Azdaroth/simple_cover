$: << File.join(File.dirname(__FILE__), "/../lib")
require 'support/vcr'

def validate_search_phrase(albums, expectations)
	(0..albums.length-1).each do |album_number|
		action = ActionMan.new(albums[album_number], "directory")
		action.make_search_phrase.should == expectations[album_number]
	end
end

