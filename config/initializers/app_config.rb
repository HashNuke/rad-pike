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

end
