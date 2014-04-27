class Api::AssetsController < ApplicationController
  before_filter :check_format, :authenticate!
  respond_to :json

  def index
    @assets = current_user.assets.where("folder_id is null and is_chunk = false").order("uploaded_file_updated_at desc")
  end

  def create
    safe_params = params.require(:file).permit(:uploaded_file, :path, :file_id, :prev_file_id, :is_modified)
    logger.info safe_params.inspect
    safe_params[:is_chunk] = true if safe_params[:uploaded_file].original_filename.split(".").last == "tmp"
    @asset = @current_user.assets.new(safe_params)
    render :json => {errors: @asset.errors}, :status => 500 unless @asset.save
  end

  def show
    @asset = @current_user.assets.find(params[:id])
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
