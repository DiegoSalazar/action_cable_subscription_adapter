require "action_cable/subscription_adapter/redis"

# Override ActionCable's Redis adapter to use a configurable adapter
module ActionCable::SubscriptionAdapter
  class CustomAdapter < Redis
    def redis_connector
      ActionCableSubscriptionAdapter.redis_connector.call self
    end
  end  
end
