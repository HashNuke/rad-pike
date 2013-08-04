class WidgetsController < ApplicationController
  layout false

  def support
    response.headers["X-Frame-Options"] = "ALLOW FROM http://roverchat.dev"
  end
end
