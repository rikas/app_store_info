require 'json'
require 'faraday'

module AppStoreInfo
  class API
    # The URL to lookup an app. The first variable is the region (us, pt, kor, etc..) and the
    # second one is the application id (i.e. 599015198).
    URL_TEMPLATE = 'https://itunes.apple.com/%s/lookup?id=%s'.freeze

    attr_accessor :id, :url

    def initialize(id, region = AppStoreInfo::DEFAULT_REGION)
      @id = id
      @region = region
      @url = format(URL_TEMPLATE, region, id)
    end

    def parse
      response = Faraday.get(url)

      unless response.status == 200 && response.body
        raise ConnectionError, "Cound't connect to app store API"
      end

      parse_json(response.body)
    end

    private

    def parse_json(body)
      json = JSON.parse(body)

      raise EntryNotFound, 'No results' unless json.key?('results')

      json = json['results'].first

      # If the JSON exists and it's a mobile app (to avoid OS X apps)
      unless json && json['supportedDevices']
        raise EntryNotFound, "App not found or unavailable on '#{@region}' region"
      end

      json
    rescue JSON::ParserError => error
      raise ParseError, error.message
    end
  end
end
