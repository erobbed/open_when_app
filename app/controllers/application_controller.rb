class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user, :current_user_categories, :current_user_category_post_count, :current_user_category_posts, :post_color_rgbs

  # , :user_average_duration, :max_user_duration


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
    all_durations = Visit.all[0...-1].map {|visit| (visit.ended_at - visit.started_at)/60}

    @total_duration = all_durations.inject(:+)
    @longest_duration = all_durations.max

    top_senders = User.all.select{|user| user.posts.count > user.opens.count}
    @ratio = ((top_senders.count.to_f / User.all.count) * 100)

    @most_popular_category = Category.all.max_by {|category| category.posts.count}

    @top_three_tags = Tag.all.max_by(3) {|tag| tag.posts.count}.reverse
  end

  def post_color_rgbs
    [[88, 193, 225], [239, 164, 97], [238, 160, 186], [203, 223, 136], [51, 146, 202], [186, 144, 192], [234, 87, 95]]
  end

  # def user_average_duration
  #   user_durations = current_user.visits[0...-1].map {|visit| (visit.ended_at - visit.started_at)/60}
  #   total_user_duration = user_durations.inject(:+)
  #   (total_user_duration / current_user.visits[0...-1].count).round(2)
  # end
  #
  # def max_user_duration
  #   user_durations = current_user.visits[0...-1].map {|visit| (visit.ended_at - visit.started_at)/60}
  #   user_durations.max.round(2)
  # end

end
