require 'rails_helper'
RSpec.describe 'Invoices', type: :system do
  it 'should render new' do
    visit '/users/new'
  end
end
