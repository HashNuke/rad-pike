module ExampleApp
  class MainController < ApplicationController
    def index
      @base_url = "#{request.protocol}#{request.host_with_port}"
    end
  end
end