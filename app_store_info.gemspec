lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'app_store_info/version'

Gem::Specification.new do |spec|
  spec.name          = 'app_store_info'
  spec.version       = AppStoreInfo::VERSION
  spec.authors       = ['Ricardo Otero']
  spec.email         = ['oterosantos@gmail.com']

  spec.summary       = 'App Store parser'
  spec.description   = 'Get details about any app in the Apple App Store'
  spec.homepage      = 'https://github.com/rikas/app_store_info'
  spec.license       = 'MIT'

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }

  spec.add_dependency 'faraday', '~> 0.9'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'rubocop', '~> 0.49'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.3'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 1.22'
end
