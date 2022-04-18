require 'rails_helper'
RSpec.describe "Home", type: :system do
  it 'should redirect to invoices if user is logged in' do
    user = create(:user)
    user_token = create(:user_token, user:, confirmed_at: DateTime.now)

    sign_in_as(user_token.token)

    visit '/'
    expect(page).to have_current_path(invoices_path)
  end
end
