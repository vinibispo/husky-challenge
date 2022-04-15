class Sessions::NewController < ApplicationController
  def call
   result =  LoginLink.valid?(request.original_url)
    if result
      session[:current_user_token] = params[:token]
      redirect_to invoices_path
    else
      render 'sessions/new'
    end
  end
end
