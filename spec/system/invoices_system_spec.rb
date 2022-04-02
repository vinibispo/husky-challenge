require 'rails_helper'

RSpec.describe 'Invoices', type: :system do
  it 'shows unauthorized when has no access' do
    visit '/invoices'
    expect(page).to have_content 'Acesso não autorizado!'
  end
end
