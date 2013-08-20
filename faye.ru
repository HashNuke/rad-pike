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
  timeout: 3,
  engine:  engine_opts.merge(AppConfig.redis_opts)
)

#TODO using this extension slows down messaging 10x.
# Find some other way. Shortcut: change channel conneec
# faye_server.add_extension(FayeAuth.new(redis: redis))
run faye_server
