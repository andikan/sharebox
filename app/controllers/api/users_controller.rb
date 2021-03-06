class Api::UsersController < ApplicationController
  before_filter :check_format, :authenticate!
  respond_to :json

  def self
    logger.info @current_user.errors.inspect if @current_user.errors.any?
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

    logger.info @current_user.errors.inspect if @current_user.errors.any?
    @current_user
  end

  def authenticate!
    render :json => { error: "401 Unauthorized" }, :status => 401 unless current_user
    render :json => { errors: @current_user.errors }, :status => 500 if @current_user.errors.any?
  end
end
