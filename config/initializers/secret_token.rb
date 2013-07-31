###########################################################################################
# CREDIT below is a minor modification of smashwilson's contribution                      #
# https://github.com/gitlabhq/gitlabhq/pull/4040/                                         #
# to https://github.com/gitlabhq/gitlabhq/blob/master/config/initializers/secret_token.rb #
###########################################################################################

require 'securerandom'

def find_secret_token
  secret_file = Rails.root.join ".secret"
  return File.read.chomp if File.exist?(secret_file)
  secret = SecureRandom.hex(64)
  File.write(secret_file, secret)
  secret
end

Ranger::Application.config.secret_key_base = find_secret_token
