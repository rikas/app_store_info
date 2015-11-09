[![Build Status](https://travis-ci.org/rikas/app_store_info.svg)](https://travis-ci.org/rikas/app_store_info)

# AppStoreInfo

Get details about any app in the Apple App Store. This gem uses iTunes lookup method to get information about apps. (i.e. https://itunes.apple.com/us/lookup?id=343200656).

Compatible with ruby >= 1.9.3

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'app_store_info'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install app_store_info

## Usage

You first have to read the app details, using the store URL or directly with the ID:

```ruby
app = AppStoreInfo.read_url('https://itunes.apple.com/gb/app/angry-birds/id343200656?mt=8')
app = AppStoreInfo.read(343200656)
app = AppStoreInfo.read(343200656, 'gb') # You can give a particular region or it will use 'us'
```

Then you have some attributes that can be read easily:

```ruby
app.id                  # => 343200656
app.name                # => "Angry Birds"
app.url                 # => "http://www.angrybirds.com/"
app.average_user_rating # => 4.5
app.user_rating_count   # => 222131
app.genre_ids           # => ["6014", "7003", "6016", "7001"]
app.price               # => 0.79
app.currency            # => "GBP"
app.supported_devices   # => ["iPhone-3GS", "iPhone4", "iPodTouchFourthGen", ...]
app.company             # => "Rovio Entertainment Ltd"
app.description         # => "Use the unique powers of the Angry Birds to destroy ...
app.minimum_os_version  # => "6.0"
app.features            # => ["gameCenter"]
```

You can also check if the app is Universal:

```ruby
app.universal? # => false
```

Last, you can check the details about the latest version of the app:
```ruby
current_version = app.current_version

current_version.average_user_rating # => 4.0
current_version.user_rating_count   # => 191
current_version.number              # => "5.2.0"
current_version.release_notes       # => "We popped some pesky bugs!"
```

If you need to get the genre names there's an helper method for that:
```ruby
app.genre_names # => ["Games", "Action", "Arcade", "Entertainment"]
```

Keep in mind that the information can be localized if you request for a particular region
information. Ratings, currency, price etc. can change.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rikas/app_store_info.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
