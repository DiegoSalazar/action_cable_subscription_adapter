# ActionCableSubscriptionAdapter

Implements a configuration option that allows you to inject a custom configurable Redis client
For ActionCable to use in its SubscriptionAdapter. This is useful if you use something like Redis::Namespace
Which needs to be configured with a Redis URL and Namespace name usually coming from ENV vars. Rail's `cable.yml` is insufficient for this because it only allows URL configuration of the Redis client. You can also use this gem to using distributed Redis with Makara.

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

Set the adapter in `config/cable.yml`

```
development:
  adapter: custom_adapter

test:
  adapter: async

production:
  adapter: custom_adapter
```

The `custom_adapter` will make ActionCable load this gem's SubscriptionAdapter rather than its built in one. Then...

Create an initializer and set your custom Redis client.
Example:

```ruby
# config/initializers/action_cable_subscription_adapter.rb

ActionCableSubscriptionAdapter.config do |c|
  c.redis_connector = MyRedisClient.new your: "options"
end
```

The custom Redis client needs to conform to the [redis-rb](https://github.com/redis/redis-rb) gem's API.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DiegoSalazar/action_cable_subscription_adapter.
