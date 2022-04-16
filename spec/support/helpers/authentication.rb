# helpers for authentication on test
module Helpers::Authentication
  def sign_in_as(token)
    visit '/sessions/new'
    fill_in field('tokens.token'), with: token
    click_on button('sessions.create')
  end
end
