# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "enumeration/version"

Gem::Specification.new do |s|
  s.name        = "enumeration"
  s.version     = Enumeration::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kelly D. Redding"]
  s.email       = ["kelly@kelredd.com"]
  s.homepage    = "http://github.com/kelredd/enumeration"
  s.summary     = %q{add enumerated value attributes to your ruby classes}
  s.description = %q{add enumerated value attributes to your ruby classes}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("bundler", ["~> 1.0"])
  s.add_development_dependency("assert", ["~> 0.7"])
end
