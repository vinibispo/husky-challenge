# helpers for authentication on test
module Helpers::Authentication
  def sign_in_as(token)
    visit '/'
    fill_in 'Token', with: token
    click_on 'Log In'
  end
end
