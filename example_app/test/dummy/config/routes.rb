Rails.application.routes.draw do

  mount ExampleApp::Engine => "/example_app"
end
