if vcap = ENV['VCAP_SERVICES']
  # cloudfoundry stuff
  services = JSON.parse(vcap)
  redis_key = services.keys.select { |svc| svc =~ /redis/i }.first
  redis = services[redis_key].first['credentials']
  redis_conf = {:db => 1, :host => redis['hostname'], :port => redis['port'], :password => redis['password']}
  Ohm.connect(redis_conf)
  $redis = Ohm.redis
else  
  uri = URI.parse(ENV["REDISTOGO_URL"]) # Heroku convention. See development.rb.
  redis_conf = {:db => 0, :host => uri.host, :port => uri.port, :password => uri.password }
  Ohm.connect(redis_conf)
  $redis = Ohm.redis
  puts "Initializing redis connection. Got $redis = " + $redis.inspect
end
