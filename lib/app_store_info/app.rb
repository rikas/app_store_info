require 'app_store_info/json_accessors'

module AppStoreInfo
  class App
    include AppStoreInfo::JSONAccessors

    attr_reader :current_version

    json_accessors id: 'trackId', name: 'trackCensoredName', domain: 'sellerUrl',
                   average_user_rating: 'averageUserRating', user_rating_count: 'userRatingCount',
                   genre_ids: 'genreIds', price: 'price', currency: 'currency',
                   supported_devices: 'supportedDevices', company: 'artistName',
                   description: 'description', minimum_os_version: 'minimumOsVersion',
                   features: 'features'

    GENRES = {
      6018 => 'Books',
      6000 => 'Business',
      6022 => 'Catalogs',
      6017 => 'Education',
      6016 => 'Entertainment',
      6015 => 'Finance',
      6023 => 'Food & Drink',
      6014 => 'Games',
      6013 => 'Health & Fitness',
      6012 => 'Lifestyle',
      6020 => 'Medical',
      6011 => 'Music',
      6010 => 'Navigation',
      6009 => 'News',
      6021 => 'Magazines & Newspapers',
      6008 => 'Photo & Video',
      6007 => 'Productivity',
      6006 => 'Reference',
      6005 => 'Social Networking',
      6004 => 'Sports',
      6003 => 'Travel',
      6002 => 'Utilities',
      6001 => 'Weather',

      # Games subgenres
      7001 => 'Action',
      7002 => 'Adventure',
      7003 => 'Arcade',
      7004 => 'Board',
      7005 => 'Card',
      7006 => 'Casino',
      7007 => 'Dice',
      7008 => 'Educational',
      7009 => 'Family',
      7011 => 'Music',
      7012 => 'Puzzle',
      7013 => 'Racing',
      7014 => 'Role Playing',
      7015 => 'Simulation',
      7016 => 'Sports',
      7017 => 'Strategy',
      7018 => 'Trivia',
      7019 => 'Word',

      # Magazines & Newspapers subgenres
      13007 => 'Arts & Photography',
      13006 => 'Automotive',
      13008 => 'Brides & Weddings',
      13009 => 'Business & Investing',
      13010 => "Children's Magazines",
      13011 => 'Computers & Internet',
      13012 => 'Cooking, Food & Drink',
      13013 => 'Crafts & Hobbies',
      13014 => 'Electronics & Audio',
      13015 => 'Entertainment',
      13002 => 'Fashion & Style',
      13017 => 'Health, Mind & Body',
      13018 => 'History',
      13003 => 'Home & Garden',
      13019 => 'Literary Magazines & Journals',
      13020 => "Men's Interest",
      13021 => 'Movies & Music',
      13001 => 'News & Politics',
      13004 => 'Outdoors & Nature',
      13023 => 'Parenting & Family',
      13024 => 'Pets',
      13025 => 'Professional & Trade',
      13026 => 'Regional News',
      13027 => 'Science',
      13005 => 'Sports & Leisure',
      13028 => 'Teens',
      13029 => 'Travel & Regional',
      13030 => "Women's Interest"
    }.freeze

    def initialize(json)
      read_json_accessors(json)

      @artwork = json['artworkUrl512'] || json['artworkUrl100']

      @current_version = read_current_version(json)
    end

    def universal?
      @features.include?('iosUniversal')
    end

    def genre_names
      @genre_ids.map { |genre| GENRES[genre.to_i] }
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
