class UserMailer < ApplicationMailer
  default from: 'hello@openwhen.co'

  def welcome_email(user)
    @user = user
    @url  = 'localhost:3000/'
    mail(to: @user.email, subject: 'Welcome to Open When')
  end
end
