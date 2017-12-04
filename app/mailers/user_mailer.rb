class UserMailer < ApplicationMailer
  default from: 'hello@openwhen.co'

  def welcome_email(user)
    @user = user
    @url  = 'www.openwhen.co'
    mail(to: @user.email, subject: 'Welcome to Open When')
  end

  def new_openwhen(recipient)
    @user = recipient
    @url  = 'www.openwhen.co'
    mail(to: @user.email, subject: 'Someone sent you a message!')
  end
end
