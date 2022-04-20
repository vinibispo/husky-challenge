class Api::V1::ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods
end
