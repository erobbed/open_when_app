class UserMailer < ApplicationMailer
  default from: 'hello@openwhen.co'

  def welcome_email(user)
    @user = user
    @url  = 'localhost:3000/'
    mail(to: @user.email, subject: 'Welcome to Open When')
  end

  def new_openwhen(recipient)
    @user = recipient
    @url  = 'localhost:3000/'
    mail(to: @user.email, subject: 'Someone sent you a message!')
  end
end
