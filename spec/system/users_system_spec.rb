require 'rails_helper'
RSpec.describe 'Users', type: :system do
  it 'should create a user (generate access token)' do
    user = build(:user)
    visit '/users/register'

    fill_in User.human_attribute_name('email'), with: user.email

    click_on button('users.create')

    expect(page).to have_content(flash('users.create.success'))
    expect(page).to have_current_path(root_path)
  end

  it 'should login user' do
    user = create(:user)
    user_token = create(:user_token, user:, confirmed_at: DateTime.now)

    visit '/sessions/new'

    fill_in User.human_attribute_name('token'), with: user_token.token

    click_on button('sessions.create')
    expect(page).to have_current_path(invoices_path)
  end

  it 'should not login user' do
    user = create(:user)
    token = '123456'

    visit '/sessions/new'

    fill_in User.human_attribute_name('token'), with: token

    click_on button('sessions.create')

    expect(page).to have_current_path(new_session_path)
  end

  it 'should login user directly' do
    user = create(:user)
    user_token = create(:user_token, user:)
    UserMailer.with(user: user, token: user_token.token).send_token.deliver_now

    click_email_link(0)

    expect(page).to have_current_path(invoices_path)
    expect(page).to have_content('Invoices')

  end
end
