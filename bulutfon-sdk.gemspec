# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bulutfon-sdk/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Bulutfon']
  gem.email         = ['info@bulutfon.com']
  gem.description   = %q{Official Ruby Sdk}
  gem.summary       = %q{Official Ruby Sdk}
  gem.homepage      = 'https://github.com/bulutfon/ruby-sdk'
  gem.license       = 'MIT'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'bulutfon-sdk'
  gem.require_paths = ['lib']
  gem.version       = BulutfonSdk::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '>= 1.1.1', '< 2.0'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
