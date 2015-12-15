# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bulutfon_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'bulutfon_sdk'
  spec.version       = BulutfonSdk::VERSION
  spec.authors       = ['Ismail Akbudak']
  spec.email         = ['ismail.akbudak@lab2023.com']

  spec.summary          = %q{Write a short summary, because Rubygems requires one.}
  spec.description      = %q{Write a longer description or delete this line.}
  spec.homepage         = 'https://github.com/bulutfon/ruby-sdk'
  spec.extra_rdoc_files = ['README.md', 'LICENSE.md']

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://github.com/bulutfon/ruby-sdk'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('multi_json', '>= 1.3.0')
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
