require 'rails_helper'
RSpec.describe 'Invoices', type: :system do
  it 'should create a user (generate access token)' do
    user = build(:user)
    visit '/users/new'

    fill_in :email, with: user.email
  end
end
