require 'app_store_info/version'
require 'app_store_info/api'
require 'app_store_info/app'
require 'app_store_info/regions'

module AppStoreInfo
  DEFAULT_REGION = 'us'

  def self.read(id, region = DEFAULT_REGION)
    # The region can be wrong because of the multiple app store formats (and our way of  getting) it
    # from the URL. If that's the case then just fallback to 'us'.
    region = DEFAULT_REGION unless Regions.find(region)

    json = AppStoreInfo::API.new(id, region).parse

    App.new(json)
  end

  def self.read_url(url)
    match = url.match(%r{\Ahttps://itunes.apple.com/(\w+)/.+/?id=?([\d]+)})

    fail ArgumentError, 'Invalid App Store URL' unless match

    region = match.captures.first
    id = match.captures.last

    read(id, region)
  end

  class EntryNotFound < StandardError; end

  class ConnectionError < StandardError; end

  class ParseError < StandardError; end
end
