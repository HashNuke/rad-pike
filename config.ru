require 'faye'
require ::File.expand_path('../config/environment',  __FILE__)

faye_server = Faye::RackAdapter.new(:mount => "/faye", :timeout => 10)

FAYE_CLIENT = faye_server.get_client

run Rack::URLMap.new({
    "/remote"  => faye_server,
    "/"        => Rails.application
  })
