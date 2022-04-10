class UserMailer < ApplicationMailer
  def send_token
    user = params[:user]
    mail(to: user.email, subject: "Token") do |format|
    format.html { render 'user_mailer/send_token', locals: { user: } }
    end
  end
end
