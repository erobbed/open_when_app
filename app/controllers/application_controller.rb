class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user




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

  def allthefeels
    all_durations = Visit.all[0...-1].map do |visit|
      if !visit.ended_at
        visit.ended_at = Time.now
      else
        (visit.ended_at - visit.started_at)/60
      end

    end

    @total_duration = all_durations.inject(:+)
    @longest_duration = all_durations.max

    top_senders = User.all.select{|user| user.posts.count > user.opens.count}
    @ratio = ((top_senders.count.to_f / User.all.count) * 100)

    @most_popular_category = Category.all.max_by {|category| category.posts.count}

    @top_three_tags = Tag.all.max_by(3) {|tag| tag.posts.count}.reverse
  end


end
