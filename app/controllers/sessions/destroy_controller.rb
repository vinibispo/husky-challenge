# destroy controller for sessions
class Sessions::DestroyController < ApplicationController
  def call
    session.delete(:current_user_token)
    flash[:success] = I18n.t('flash.sessions.destroy.success')
    redirect_to root_path, status: :see_other
  end
end
