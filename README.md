# ActionCableSubscriptionAdapter

Implements a configuration option that allows you to inject a custom configurable Redis client
For ActionCable to use in its SubscriptionAdapter. This is useful if you use something like Redis::Namespace
Which needs to be configured with a Redis URL and Namespace name usually coming from ENV vars. Rail's `cable.yml` is insufficient for this because it doesn't allow configuration of the Redis client.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'action_cable_subscription_adapter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install action_cable_subscription_adapter

## Usage

Inject a custom Redis client used by the ActionCable::SubscriptionAdapter
Example:

```ruby
# config/initializers/action_cable_subscription_adapter.rb

ActionCableSubscriptionAdapter.config do |c|
  c.redis_connector = MyRedisClient.new your: "options"
end
```

You can also pass a block that will run when the ActionCable workers are initialized:

```ruby
ActionCableSubscriptionAdapter.config do |c|
  c.redis_connector = ->(subscription_adapter) { 
    MyRedisClient.new your: "options"
  }
end
```

The custom Redis client needs to conform to the [Redis](https://github.com/redis/redis-rb) gem's API.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DiegoSalazar/action_cable_subscription_adapter.
