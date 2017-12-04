class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      visit = Visit.create(user_id: @user.id, started_at: Time.now)
      session[:visit_id] = visit.id
      redirect_to '/'
    else
      flash[:message] = "login failed!"
      redirect_to login_path
    end
  end

  def destroy
    # visit = Visit.find_by(id: session[:visit_id])
    # visit.update(ended_at: Time.now)
    session.clear
    redirect_to '/login'
  end

end
