class Api::UsersController < ApplicationController
  before_filter :check_format, :authenticate!
  respond_to :json

  def self
    logger.fatal @current_user.errors if @current_user.errors.any?
  end

  private
  def check_format
    render :json => {error: "invalid format"}, :status => 406 unless params[:format] == 'json'
  end

  def current_user 
    # for app 
    if request.headers["Authorization"] && result = request.headers["Authorization"].match(/Bearer (?<token>.+)/)
      token = result[:token]
      @current_user = User.find_for_facebook_access_token(token)

    # for web site
    # elsif env['warden'].user 
    #   @current_user = env['warden'].user

    # for swagger api demo
    elsif params[:access_token].present?
      @current_user = User.find_for_facebook_access_token(params[:access_token])
    end

    @current_user
  end

  def authenticate!
    render :json => { :error => "401 Unauthorized" }, :status => 410 unless current_user
  end
end
