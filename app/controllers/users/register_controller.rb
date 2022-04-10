# register controller for users
class Users::RegisterController < ApplicationController
  def call
    user = User.new
    render 'users/new', locals: { user: }
  end
end
