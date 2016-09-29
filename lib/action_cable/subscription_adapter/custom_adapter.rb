require "action_cable/subscription_adapter/redis"

# Override ActionCable's Redis adapter to use a configurable adapter
module ActionCable::SubscriptionAdapter
  class CustomAdapter < Redis
    def redis_connection
      r=ActionCableSubscriptionAdapter.redis_connector.call self
      Rails.logger.info "ActionCableSubscriptionAdapter: #{r}"
      r
    end
  end  
end
