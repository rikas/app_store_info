$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'vcr'
require 'faraday'
require 'webmock/rspec'
require 'app_store_info'

WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
end

def json_read(name)
  json_dir = File.expand_path('json', __dir__)

  file = File.read(File.join(json_dir, name))

  JSON.parse(file)
end
