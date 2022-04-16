# create controller for sessions
class Sessions::CreateController < ApplicationController
  def call
    session_model = Session.new(session_params)
    Session::Create::Flow.call(session: session_model).on_success do
      redirect_successfully
    end.on_failure do |data|
      render_error(data)
    end
  end

  private

  def session_params
    params.require(:session).permit(:token)
  end

  def redirect_successfully
    session[:current_user_token] = session_params[:token]
    redirect_to invoices_path
    flash[:notice] = I18n.t('create', scope: 'flash.sessions')
  end

  def render_error(data)
    flash[:notice] = data[:message]
    render 'sessions/new', locals: { session_model: data[:session] }, status: :unprocessable_entity
  end
end
