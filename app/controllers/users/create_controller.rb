# create controller for users
class Users::CreateController < ApplicationController
  def call
    render json: { email: params[:user][:email] }
  end
end
