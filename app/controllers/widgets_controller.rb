class WidgetsController < ApplicationController
  layout false

  def support
    # TODO should only allow the widget for the domain
    # response.headers["X-Frame-Options"] = "ALLOW-FROM http://radpike.dev"
    response.headers["X-Frame-Options"] = "ALLOWALL"
  end

  def support_widget_javascript
    @base_url = "#{request.protocol}#{request.host_with_port}"
    respond_to do |format|
      format.js { render 'support_widget' }
    end
  end

end
