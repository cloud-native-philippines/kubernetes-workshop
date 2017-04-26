require 'action_cable/subscription_adapter/redis'

puts "ActionCable::SubscriptionAdapter::Redis.redis_connector => #{ActionCable::SubscriptionAdapter::Redis.redis_connector.inspect}"

ActionCable::SubscriptionAdapter::Redis.redis_connector = lambda do |config|
  $stderr.puts "#### config => #{config.inspect}"
  redis_opts = { url: config[:url] }
  redis_opts[:sentinels] = config[:sentinels] if config.key?(:sentinels)
  $stderr.puts "#### redis_opts => #{redis_opts .inspect}"
  ::Redis.new(redis_opts)
end

puts "ActionCable::SubscriptionAdapter::Redis.redis_connector => #{ActionCable::SubscriptionAdapter::Redis.redis_connector.inspect}"
