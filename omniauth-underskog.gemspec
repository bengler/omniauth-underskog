# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'omniauth-underskog/version'

Gem::Specification.new do |gem|
  gem.name          = "omniauth-underskog"
  gem.version       = OmniAuth::Underskog::VERSION
  gem.authors       = ["Per-Kristian Nordnes"]
  gem.email         = ["per.kristian.nordnes@gmail.com"]
  gem.description   = %q{Official OmniAuth OAuth 2 strategy for Underskog.}
  gem.summary       = %q{Official OmniAuth OAuth 2 strategy for Underskog.}
  gem.homepage      = "https://github.com/origo/omniauth-underskog"

  gem.add_runtime_dependency     'omniauth', '>= 1.0.0'
  gem.add_runtime_dependency     'omniauth-oauth2', '>= 1.0.0'
  gem.add_runtime_dependency     'oauth'
  gem.add_dependency             'multi_json'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]
end
