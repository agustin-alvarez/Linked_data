# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "easy_data/version"

Gem::Specification.new do |s|
  s.name        = "easy_data"
  s.version     = EasyData::VERSION
  s.authors     = ["jnillo"]
  s.email       = ["jnillo@rubysemantic.com"]
  s.homepage    = "http://rubygems.org/gem/easy_data"
  s.summary     = "This is not a summary"
  s.description = "this is a gem description"

  s.rubyforge_project = "easy_data"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
 
  #gem dependencies:
  #All is not necesary, only is for study his methods

    #s.add_dependency(%q<addressable>, ["= 2.2.4"])
    #s.add_dependency(%q<rdf>, [">= 0"])
    #s.add_dependency(%q<haml>, [">= 3.0.0"])
    #s.add_dependency(%q<nokogiri>, [">= 1.3.3"])
   # s.add_dependency(%q<open-uri-cached>, [">= 0.0.3"])
   # s.add_dependency(%q<rdf-spec>, [">= 0"])
   # s.add_dependency(%q<rdf-isomorphic>, [">= 0.3.4"])
   # s.add_dependency(%q<rdf-n3>, [">= 0.3.1"])
   # s.add_dependency(%q<rspec>, [">= 2.1.0"])
   # s.add_dependency(%q<sxp>, [">= 0"])
   # s.add_dependency(%q<sparql-algebra>, [">= 0"])
   # s.add_dependency(%q<sparql-grammar>, [">= 0"])
   # s.add_dependency(%q<spira>, [">= 0.0.12"])
   # s.add_dependency(%q<yard>, [">= 0.6.4"])
   # s.add_dependency(%q<rdf>, [">= 0.3.3"])
   # s.add_dependency(%q<haml>, [">= 3.0.0"])
   # s.add_dependency(%q<nokogiri>, [">= 1.4.4"])
   # s.add_dependency(%q<spira>, [">= 0.0.12"])
  #  s.add_dependency(%q<rspec>, [">= 2.5.0"])
 #   s.add_dependency(%q<rdf-spec>, [">= 0.3.3"])
#    s.add_dependency(%q<rdf-isomorphic>, [">= 0.3.4"])
 #   s.add_dependency(%q<yard>, [">= 0"])

end
