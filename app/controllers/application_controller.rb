class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def redirect_if_not_authorized
    redirect_to root_path if !logged_in?
  end
end
