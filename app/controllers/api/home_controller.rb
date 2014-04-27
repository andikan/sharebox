class Api::HomeController < ApplicationController
  respond_to :json
  
  def ping
    @current_time = Time.now
  end
end
