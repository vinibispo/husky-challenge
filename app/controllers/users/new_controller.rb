# new controller for users
class Users::NewController < ApplicationController
  def call
    user = User.new
    render 'users/new', locals: { user: }
  end
end
