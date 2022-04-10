require 'rails_helper'
RSpec.describe 'Invoices', type: :system do
  it 'should create a user (generate access token)' do
    user = build(:user)
    visit '/users/register'

    fill_in User.human_attribute_name('email'), with: user.email

    click_on button('users.create')

    expect(page).to have_content(flash('users.create.success'))
    expect(page).to have_current_path(invoices_path)
  end
end
