require "action_cable_subscription_adapter/version"
require "action_cable/subscription_adapter/custom_adapter.rb"

module ActionCableSubscriptionAdapter
  # Inject a custom Redis client used by the ActionCable::SubscriptionAdapter
  # Example:
  # 
  # ActionCableSubscriptionAdapter.config do |c|
  #   c.redis_connector = MyRedisClient.new
  # end
  #
  # You can also pass a block that will run when the ActionCable workers are initialized:
  #
  # ActionCableSubscriptionAdapter.config do |c|
  #   c.redis_connector = ->(subscription_adapter) { MyRedisClient.new }
  # end
  #
  # The custom Redis client needs to conform to the Redis gem's API.
  #
  mattr_accessor :redis_connector

  def self.config(&block)
    block.call self
    @redis_connector = ->(s) { @redis_connector } unless @redis_connector.respond_to? :call
    self
  end
end
