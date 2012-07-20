# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'pairzone/version'

Gem::Specification.new do |s|
  s.name        = 'pairzone'
  s.version     = Pairzone::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Parsons", "Richard Patching"]
  s.email       = ["chrismdp@gmail.com"]
  s.summary     = "Pair with anyone, on any git repository, right now."
  s.description = "" # FIXME
  s.homepage    = "https://github.com/chrismdp/pairzone"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'gli'
  s.add_dependency 'net-ssh'
  s.add_dependency 'highline'
  s.add_dependency 'fog'

  s.add_development_dependency 'rspec',    '~> 2.10.0'
  s.add_development_dependency 'rake',     '~> 0.9.2.2'
  s.add_development_dependency 'cucumber', '~> 1.2'
  s.add_development_dependency 'aruba',    '~> 0.4'
end
