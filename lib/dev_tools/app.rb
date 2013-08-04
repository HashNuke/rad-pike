require "rails"
require "action_controller/railtie"
require "debugger"

module FunStack
  module DevTools

    class App < Rails::Application
      routes.append do
        scope module: "fun_stack" do
          scope module: "test_utils" do
            root to: "main#index"
          end
        end
      end

      config.middleware.delete "ActiveRecord::ConnectionAdapters::ConnectionManagement"
      config.middleware.delete "ActiveRecord::QueryCache"
      config.secret_key_base = SecureRandom.hex(64)
      config.eager_load = false
    end

    class MainController < ActionController::Metal
      include ActionController::Rendering
     
      def index
        render :text => "Hello world!"
      end
    end

  end
end

# # Initialize the app (originally in config/environment.rb)
# FunStack::DevTools::App.initialize!

# # Print the stack for fun!
# puts ">> Starting Rails lightweight stack"
# Rails.configuration.middleware.each do |middleware|
#   puts "use #{middleware.inspect}"
# end
# puts "run #{Rails.application.class.name}.routes"


# run FunStack::DevTools::App
