redis_conf = {:db => 1, :port => Rails.env.test? ? 6378 : 6379}
Ohm.connect(redis_conf)
$redis = Ohm.redis
puts "Initializing redis connection. Got $redis = " + $redis.inspect
