# new controller for sessions
class Sessions::NewController < ApplicationController
  def call
    result = LoginLink.valid?(request.original_url)
    if result
      session[:current_user_token] = params[:token]
      redirect_to invoices_path
    else
      session_model = Session.new 
      render 'sessions/new', locals: { session_model: session_model }
    end
  end
end
