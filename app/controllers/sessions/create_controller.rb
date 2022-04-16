class Sessions::CreateController < ApplicationController
  def call
    session_model = Session.new(session_params)
    result = Session::Create::Flow.call(session: session_model)
    result.on_success do
      session[:current_user_token] = session_params[:token]
      redirect_to invoices_path
      flash[:notice] = I18n.t('create', scope: 'flash.sessions')
    end.on_failure do |result|
      render 'sessions/new', locals: { session_model: result[:session] }
      flash[:notice] = result[:message]
    end
  end

  private

  def session_params
    params.require(:session).permit(:token)
  end
end
