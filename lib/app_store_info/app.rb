require 'app_store_info/json_accessors'
require 'ostruct'

module AppStoreInfo
  class App
    include AppStoreInfo::JSONAccessors

    attr_reader :current_version

    json_accessors id: 'trackId', name: 'trackCensoredName', url: 'sellerUrl',
                   average_user_rating: 'averageUserRating', user_rating_count: 'userRatingCount',
                   genre_ids: 'genreIds', price: 'price', currency: 'currency',
                   supported_devices: 'supportedDevices', company: 'artistName',
                   description: 'description', minimum_os_version: 'minimumOsVersion',
                   features: 'features', languages: 'languageCodesISO2A',
                   app_store_url: 'trackViewUrl'

    def initialize(json)
      read_json_accessors(json)

      @artwork = json['artworkUrl512'] || json['artworkUrl100']

      @current_version = read_current_version(json)
    end

    def universal?
      @features.include?('iosUniversal')
    end

    def genre_names
      @genre_ids.map { |genre| AppStoreInfo::GENRES[genre.to_i] }
    end

    def store_icon_url
      return unless @artwork

      @artwork.match(/\.(png|jpg|gif)\z/) ? @artwork : nil
    end

    private

    def read_current_version(json)
      version = OpenStruct.new

      version.average_user_rating = json['averageUserRatingForCurrentVersion']
      version.user_rating_count = json['userRatingCountForCurrentVersion']
      version.number = json['version']
      version.release_notes = json['releaseNotes']

      version
    end
  end
end
