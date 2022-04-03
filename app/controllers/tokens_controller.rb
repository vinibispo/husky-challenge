class TokensController < ApplicationController
  def index
  end

  def create
    if params[:token] == '123456'
      session[:current_user_token] = params[:token]

      redirect_to(invoices_path, notice: I18n.t('tokens.create.success', scope: 'flash'))
    else
      redirect_to(root_path, notice: I18n.t('tokens.create.error', scope: 'flash'))
    end
  end
end
