lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'app_store_info/version'

Gem::Specification.new do |spec|
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.name          = 'app_store_info'
  spec.version       = AppStoreInfo::VERSION
  spec.authors       = ['Ricardo Otero']
  spec.email         = ['oterosantos@gmail.com']
  spec.required_ruby_version = '2.6'

  spec.summary       = 'App Store parser'
  spec.description   = 'Get details about any app in the Apple App Store'
  spec.homepage      = 'https://github.com/rikas/app_store_info'
  spec.license       = 'MIT'

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }

  spec.add_dependency 'faraday', '~> 2.3.0'

  spec.add_development_dependency 'bundler', '~> 2.3'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
