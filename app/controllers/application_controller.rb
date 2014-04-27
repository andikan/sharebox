class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_format
  def check_format
    render :json => {error: "invalid format"}, :status => 406 unless params[:format] == 'json'
  end
end
