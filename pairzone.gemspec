# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pairzone/version"

Gem::Specification.new do |gem|
  gem.name = "pairzone"
  gem.version = Pairzone::VERSION
  gem.summary = %Q{The utility gem for the Pairzone service}
  gem.description = %Q{Pairzone allows you to create an instant, speedy environment for coding alone or with others in the cloud.}
  gem.email = "dev@edendevelopment.co.uk"
  gem.homepage = "edendevelopment.co.uk/pairzone"
  gem.authors = ["Chris Parsons"]
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
end
