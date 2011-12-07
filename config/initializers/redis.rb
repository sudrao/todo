if vcap = ENV['VCAP_SERVICES']
  # cloudfoundry stuff
  services = JSON.parse(vcap)
  redis_key = services.keys.select { |svc| svc =~ /redis/i }.first
  redis = services[redis_key].first['credentials']
  redis_conf = {:db => 1, :host => redis['hostname'], :port => redis['port'], :password => redis['password']}
  Ohm.connect(redis_conf)
  $redis = Ohm.redis
elsif Rails.env.production?
  redis_conf = {:db => 1, :host => 'todonew.heroku.com', :port => 6379}
  Ohm.connect(redis_conf)
  $redis = Ohm.redis
else  
  redis_conf = {:db => 1, :port => Rails.env.test? ? 6378 : 6379}
  Ohm.connect(redis_conf)
  $redis = Ohm.redis
  puts "Initializing redis connection. Got $redis = " + $redis.inspect
end
