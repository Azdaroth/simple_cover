require 'vcr'
require 'fakeweb'

VCR.configure do |c|
	c.cassette_library_dir = "vcr"
	c.hook_into :fakeweb
end
