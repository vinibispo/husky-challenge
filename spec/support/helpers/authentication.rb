# helpers for authentication on test
module Helpers::Authentication
  def sign_in_as(token)
    visit '/'
    fill_in field('tokens.token'), with: token
    click_on button('sign_in')
  end
end
