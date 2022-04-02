require 'rails_helper'

RSpec.describe 'Invoices', type: :system do
  it 'shows unauthorized when has no access' do
    visit '/invoices'
    expect(page).to have_content 'Acesso não autorizado!'
  end

  it 'shows invoices when user is authenticated' do
    token = '123456'
    sign_in_as(token)
    visit '/invoices'
    expect(page).to have_content 'Invoices'
  end
end
