# -*- encoding: utf-8 -*-
require File.expand_path('../lib/simple_cover/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Azdaroth"]
  gem.email         = ["azdaroth@gmail.com"]
  gem.description   = %q{Simple aoo downloading covers and standarizing albums' names}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "simple_cover"
  gem.require_paths = ["lib"]
  gem.version       = SimpleCover::VERSION
  
  gem.add_dependency("rest-client")
  gem.add_dependency("crack")

end
