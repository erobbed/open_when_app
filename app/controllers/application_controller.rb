class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user, :current_user_categories, :current_user_category_post_count, :current_user_category_posts


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
    current_user.opens.map do |post|
      post.category
    end.uniq
  end

  def current_user_category_post_count(category)
    category.posts.where(recipient_id: current_user.id).count
  end

  def current_user_category_posts(category)
    category.posts.where(recipient_id: current_user.id)
  end

  def allthefeels
    @total_duration = Visit.all[0...-1].map do |visit|
      (visit.ended_at - visit.started_at)/60
    end.inject(:+).round(2)

    top_senders = User.all.select{|user| user.posts.count > user.opens.count}
    @ratio = ((top_senders.count.to_f / User.all.count) * 100).round(0)
  end

end
