require "action_cable/subscription_adapter/redis"

# Override ActionCable's Redis adapter to use a configurable adapter
module ActionCable::SubscriptionAdapter
  class CustomAdapter < Redis
    def redis_connection
      ActionCableSubscriptionAdapter.redis_connector
    end
  end  
end
