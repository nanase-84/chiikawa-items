class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :current_user
  add_flash_types :success, :danger, :info, :warning

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  private

  def require_login
    return if logged_in?

    redirect_to login_path
  end

  def not_authenticated
    redirect_to login_path
  end
end
