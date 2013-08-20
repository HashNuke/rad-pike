class WidgetsController < ApplicationController
  layout false

  def support
    # TODO should only allow the widget for the domain
    # response.headers["X-Frame-Options"] = "ALLOW-FROM http://radpike.dev"
    response.headers["X-Frame-Options"] = "ALLOWALL"
  end

end
