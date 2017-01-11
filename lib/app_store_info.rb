require 'app_store_info/version'
require 'app_store_info/api'
require 'app_store_info/app'
require 'app_store_info/regions'
require 'app_store_info/genres'

module AppStoreInfo
  DEFAULT_REGION = 'us'.freeze

  def self.read(id, region = DEFAULT_REGION)
    # The region can be wrong because of the multiple app store formats (and our way of  getting) it
    # from the URL. If that's the case then just fallback to 'us'.
    region = DEFAULT_REGION unless Regions.find(region)

    json = AppStoreInfo::API.new(id, region).parse

    App.new(json)
  end

  def self.read_url(url)
    match = url.match(%r{\Ahttps://itunes.apple.com/(\w+)/.+/?id=?([\d]+)})

    raise InvalidURLError, 'Invalid App Store URL' unless match

    region = match.captures.first
    id = match.captures.last

    read(id, region)
  end

  class GenericError < StandardError; end

  class InvalidURLError < GenericError; end

  class EntryNotFound < GenericError; end

  class ConnectionError < GenericError; end

  class ParseError < GenericError; end
end
