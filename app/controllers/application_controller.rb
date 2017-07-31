class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user


  def logged_in?
    !!session[:user_id]
  end

  def home
    # byebug
  end

  # def current_user
  #   @user ||= User.find_by(id: session[:user_id])
  # end

end
