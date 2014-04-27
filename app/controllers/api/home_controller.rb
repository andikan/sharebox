class Api::HomeController < ApplicationController
  before_filter :check_format
  respond_to :json
  
  def ping
    @current_time = Time.now
  end

  private
  def check_format
    render :json => {error: "invalid format"}, :status => 406 unless params[:format] == 'json'
  end
end
