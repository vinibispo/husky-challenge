# create controller for users
class Users::CreateController < ApplicationController
  def call
    ::User::Register::Flow
      .call(params:)
      .on_success { redirect_successfully }
      .on_failure(:blank_email) { |error| redirect_error(error[:message]) }
      .on_failure(:invalid_email) { |error| redirect_error(error[:message]) }
      .on_failure(:parameter_missing) { |error| redirect_error(error[:message]) }
  end

  private

  def redirect_successfully
    redirect_to root_path
    flash[:success] = I18n.t("flash.users.create.success")
  end

  def redirect_error(error)
    flash[:danger] = error
    redirect_to register_users_path
  end
end
