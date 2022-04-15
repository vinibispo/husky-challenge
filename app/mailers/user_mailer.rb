# mailer for user
class UserMailer < ApplicationMailer
  def send_token
    user = params[:user]
    token = params[:token]
    url = LoginLink.create!(email: user.email, token:)
    mail(to: user.email, subject: "Token") do |format|
      format.html { render 'user_mailer/send_token', locals: { user:, url:, token: } }
    end
  end
end
