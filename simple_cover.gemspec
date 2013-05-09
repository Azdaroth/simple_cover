# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors       = ["Azdaroth"]
  gem.email         = ["azdaroth@gmail.com"]
  gem.description   = %q{Simple app downloading covers and standarizing albums' names}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "simple_cover"
  gem.require_paths = ["lib"]
  gem.version = 0.1
  
  gem.add_dependency("rest-client")
  gem.add_dependency("crack")

end
