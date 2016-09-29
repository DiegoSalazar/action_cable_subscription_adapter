# ActionCableSubscriptionAdapter

Implements a configuration option that allows you to inject a any Redis client for ActionCable to use in its SubscriptionAdapter. 

This is useful if you use something like Redis::Namespace which needs to be configured with a Redis URL and Namespace name usually coming from ENV vars. Rail's `cable.yml` is insufficient for this because it only allows URL configuration of the Redis client. You can also use this gem if you're using distributed Redis with Makara.

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

Set the `custom_adapter` in the `adapter` option in `config/cable.yml`

```
development:
  adapter: custom_adapter

test:
  adapter: async

production:
  adapter: custom_adapter
```

The `custom_adapter` will make ActionCable load this gem's SubscriptionAdapter rather than the Rails built in one. Then...

Create an initializer and set your custom Redis client.
Example:

```ruby
# config/initializers/action_cable_subscription_adapter.rb

ActionCableSubscriptionAdapter.config do |c|
  c.redis_connector = MyRedisClient.new your: "options"
end
```

You can also assign a proc to `c.redis_connector`:

```ruby
ActionCableSubscriptionAdapter.config do |c|
  c.redis_connector = ->(subscription_adapter) { MyRedisClient.new your: "options" }
end
```

### Custom Redis Client

The custom Redis client needs to conform to the [redis-rb](https://github.com/redis/redis-rb) gem's API.

### Redis::Namespace

In the case of Redis::Namespace you have to `stream_from` the namespaced channel. In your channel object where you declare `stream_from` do something like this:

```ruby
class YourChannel < ApplicationCable::Channel
  def subscribed
    stream_from "your_namespace:your_channel"
  end
end
```

### Multiprocess Servers

If you're using a multiprocess server such as Puma or Unicorn you need to create a new instance of the Redis client by using a proc for the `redis_connector`.
Example:

```ruby
ActionCableSubscriptionAdapter.config do |c|
  c.redis_connector = ->(*) { Redis::Namespace.new REDIS_NAMESPACE, redis: Redis.new(url: REDIS_URL) }
end
```

Since ActionCable runs in threads, each thread will call `redis_connector` when subscribing to the channel. Using a proc in this way means a new instance of the Redis client will connect in each thread and therefore each redis client instance will have its own TCP socket.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DiegoSalazar/action_cable_subscription_adapter.
