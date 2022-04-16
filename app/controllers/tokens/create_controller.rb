# create controller for tokens
class Tokens::CreateController < ApplicationController
  def call
    if params[:token] == '123456'
      session[:current_user_token] = params[:token]

      redirect_to(invoices_path)
      flash[:success] = I18n.t('tokens.create.success', scope: 'flash')
    else
      redirect_to(root_path)
      flash[:danger] = I18n.t('tokens.create.error', scope: 'flash')
    end
  end
end
