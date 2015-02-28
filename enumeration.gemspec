# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "enumeration/version"

Gem::Specification.new do |gem|
  gem.name        = "enumeration"
  gem.version     = Enumeration::VERSION
  gem.authors     = ["Kelly Redding", "Collin Redding"]
  gem.email       = ["kelly@kellyredding.com", "collin.redding@me.com"]
  gem.description = %q{Add enumerated value attributes to your ruby classes.}
  gem.summary     = %q{Add enumerated value attributes to your ruby classes.}
  gem.homepage    = "http://github.com/redding/enumeration"
  gem.license     = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency("assert", ["~> 2.13"])

end
