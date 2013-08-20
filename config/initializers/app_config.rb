class AppConfig

  def self.config_file
    if defined?(Rails)
      @config_file ||= Rails.root.join "config", "application.toml"
    else
      @config_file ||= File.expand_path('../../application.toml', __FILE__)
    end
  end

  def self.values
    @toml ||= ::TOML.load_file(config_file)
  end

  def self.redis_opts
    return @redis_opts if !@redis_options.nil?

    @redis_opts = {host: values["redis"]["host"]}

    unless values["redis"]["port"].empty?
      @redis_opts.merge!(port: values["redis"]["port"])
    end

    unless values["redis"]["password"].empty?
      @redis_opts.merge!(port: values["redis"]["password"])
    end
    @redis_opts
  end

  def self.redis
    @redis ||= Redis.new(redis_opts)
  end

  def self.faye_client(host)
    Faye::Client.new("http://#{host}:#{values['faye']['port']}/faye")
  end

end
