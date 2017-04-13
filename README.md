# ActionQuery

Lightweight Jquery based extension to handle object lifecycle through Jquery's ajax xhr requests.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'action_query'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install action_query

Install the action_query config if you have non standard custom routes

    $ rails g action_query:install

And then edit the file config/initializers/action_query.rb to declare which routes return array's vs members

## Usage

Javascript classes with the ActionQuery name space will be created.  These classes will coincide with models that have routes in the routes.rb.
After changes to routes.rb you may need to clear the cache `rails tmp:cache:clear`

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cmoodyEIT/action_query. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
