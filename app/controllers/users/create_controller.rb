# create controller for users
class Users::CreateController < ApplicationController
  def call
    user = User.new(User::Params.to_save(params))
    respond_to do |format|
      which_screen_should_render(format, user)
    end
  end

  private

  def which_screen_should_render(format, user)
    if user.save
      format.html { redirect_to invoices_url, notice: I18n.t("flash.users.create.success") }
      format.json { render 'users/show', locals: { user: }, status: :created }
    else
      format.html { render 'users/new', locals: { user: }, status: :unprocessable_entity }
      format.json { render json: user.errors, status: :unprocessable_entity }
    end
  end
end
