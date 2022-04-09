# new controller for users
class Users::NewController < ApplicationController
  def call
    render 'users/new'
  end
end
