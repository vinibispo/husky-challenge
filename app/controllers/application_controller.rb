# application controller
class ApplicationController < ActionController::Base
  add_flash_types :danger, :success

  private

  def redirect_if_is_not_authenticated
    redirect_to(root_path)
    flash[:danger] = I18n.t('flash.user.unauthorized')
  end

  def authenticated?
    session[:current_user_token].present?
  end

  def html?
    request.format.html?
  end

  def not_authenticated_and_html?
    !authenticated? && html?
  end
end
