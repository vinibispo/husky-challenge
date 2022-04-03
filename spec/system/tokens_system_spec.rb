require 'rails_helper'
RSpec.describe 'Tokens', type: :system do
  it 'logs in on app' do
    token = '123456'
    sign_in_as(token)
    expect(page).to have_content('Token válido')
    expect(page).to have_current_path(invoices_path)
  end

  it 'does not log in on app' do
    token = '124567'
    sign_in_as(token)
    expect(page).to have_content('Token inválido')
    expect(page).to have_current_path(root_path)
  end
end
