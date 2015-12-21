# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bulutfon_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'bulutfon_sdk'
  spec.version       = BulutfonSDK::VERSION
  spec.authors       = ['Ismail Akbudak']
  spec.email         = ['ismail.akbudak@lab2023.com']

  spec.summary          = %q{Bulutfon Ruby SDK.}
  spec.description      = %q{Bulutfon API SDK for ruby & ruby on rails.}
  spec.homepage         = 'https://github.com/bulutfon/ruby-sdk'
  spec.extra_rdoc_files = ['README.md', 'LICENSE.md']
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'multi_json', '~> 1.11', '>= 1.11.0'
  spec.add_dependency('mime-types', '~> 1.25')
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 0'
end
