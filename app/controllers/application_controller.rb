class ApplicationController < ActionController::Base
  def nav_bar_helper
    if current_page?(controller: 'shows', action: 'index')
      @class = "active"
    end
  end
end
