class ApplicationController < ActionController::Base
  protect_from_forgery

  def ensure_that_signed_in
    redirect_to signin_path, notice: 'you should be signed in' if current_user.nil?
  end

  def ensure_that_admin
    redirect_to :back, notice: 'you are not an admin' unless current_user.admin
  end

  helper_method :current_user
  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end
end
