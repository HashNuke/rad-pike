require 'toml'
require 'redis'
require 'faye'
require 'faye/redis'

require File.expand_path('../config/initializers/app_config.rb', __FILE__)
require File.expand_path('../lib/faye_auth.rb', __FILE__)


engine_opts = { type: Faye::Redis }

redis = Redis.new(AppConfig.redis_opts.merge(driver: :hiredis))

faye_server = Faye::RackAdapter.new(
  mount:   '/faye',
  timeout: 5,
  engine:  engine_opts.merge(AppConfig.redis_opts)
)

#TODO using the FayeAuth extension slows down messaging 10x when authing with redis.
# faye_server.add_extension(FayeAuth.new(redis: redis))

#TODO allow subscription only to channels with /conversations/:id/:token
# and the conversation list channel

run faye_server
