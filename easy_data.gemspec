# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "easy_data/version"

Gem::Specification.new do |s|
  s.name        = "easy_data3"
  s.version     = EasyData::VERSION
  s.authors     = ["jnillo"]
  s.email       = ["jnillo@rubysemantic.com"]
  s.homepage    = "http://rubygems.org/gem/easy_data"
  s.summary     = "Blau blau Easily publish the linked data data model of your project RoR"
  s.description = "Easily publish the linked data data model of your project RoR 3.x"

  s.rubyforge_project = "easy_data"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
 
  #gem dependencies:
  #All is not necesary, only is for study his methods

    s.add_dependency(%q<hpricot>, [">= 0.8.4"])
    s.add_dependency(%q<haml>, [">= 3.0.0"])
    s.add_dependency(%q<rails>, ["> 3.0.0"])
end
