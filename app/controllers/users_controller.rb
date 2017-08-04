class UsersController < ApplicationController

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      session[:user_id] = @user.id
      visit = Visit.create(user_id: @user.id, started_at: Time.now)
      session[:visit_id] = visit.id
      redirect_to home_path
    else
      flash[:message] = "Please try a unique username / email combination or your email is invalid"
      redirect_to new_user_path
    end
  end

  def edit
    current_user
  end


  def show
    @user = User.find_by(id: params[:id])
  end

  def update
    current_user.update(user_params)
    redirect_to user_path(@user)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end


end
