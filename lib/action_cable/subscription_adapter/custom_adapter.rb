require "action_cable/subscription_adapter/redis"

# Override ActionCable's Redis adapter to use a configurable adapter
module ActionCable::SubscriptionAdapter
  class CustomAdapter < Redis
    def redis_connection
      redis = ActionCableSubscriptionAdapter.redis_connector
      redis = redis.call self if redis.is_a? Proc
      redis
    end
  end  
end
