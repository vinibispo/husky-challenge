# index controller for tokens
class Tokens::IndexController < ApplicationController
  def call
    render 'tokens/index'
  end
end
