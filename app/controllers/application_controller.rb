class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user, :current_user_categories


  def logged_in?
    !!session[:user_id]
  end

  def home
    if !logged_in?
      redirect_to login_path
    end
  end

  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end

  def current_user_categories
    current_user.posts.map do |post|
      post.category
    end.uniq
  end

end
