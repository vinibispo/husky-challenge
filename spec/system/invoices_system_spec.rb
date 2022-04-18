require 'rails_helper'

RSpec.describe 'Invoices', type: :system do
  it 'shows unauthorized when has no access' do
    visit '/invoices'

    expect(page).to have_content flash('user.unauthorized')
  end

  it 'shows invoices when user is authenticated' do
    user = create(:user)
    token = create(:user_token, user:, confirmed_at: DateTime.now).token

    sign_in_as(token)
    visit '/invoices'

    expect(page).to have_content 'Invoices'
    expect(page).to have_content button('invoices.new')
  end

  it 'should go to the new invoice url' do
    user = create(:user)
    token = create(:user_token, user:, confirmed_at: DateTime.now).token

    sign_in_as(token)

    click_on button('invoices.new')

    expect(page).to have_current_path(new_invoice_path)

    expect(page).to have_content('New')
  end

  it 'creates an invoice when user is authenticated and go to the url of new' do
    user = create(:user)
    token = create(:user_token, user:, confirmed_at: DateTime.now).token

    sign_in_as(token)
    visit '/invoices/new'

    invoice = build(:invoice)

    fill_in field('invoices.invoice_number'), with: invoice.invoice_number
    fill_in field('invoices.invoice_date'), with: invoice.invoice_date
    fill_in field('invoices.total_amount_due'), with: invoice.total_amount_due
    fill_in field('invoices.emails'), with: invoice.emails

    click_on button('invoices.create')

    expect(page).to have_content(flash('invoices.create.success'))
  end

  it 'sends emails when click on send emails in show page' do
    user = create(:user)
    token = create(:user_token, user:, confirmed_at: DateTime.now).token

    sign_in_as(token)
    invoice = create(:invoice, user:)
    Invoice::Create::GeneratePdf.call(invoice:)

    visit "/invoices/#{invoice.id}"
    fill_in Invoice.human_attribute_name('emails'), with: "vini@google.com,test@google.com"

    click_on button('invoices.send_emails')
    expect(page).to have_content(flash('invoices.send_emails.success'))
    expect(page).to have_current_path(invoice_path(invoice))
  end

  it 'logout when user is authenticated' do
    user = create(:user)
    token = create(:user_token, user:, confirmed_at: DateTime.now).token

    sign_in_as(token)

    click_on button('sign_out')

    expect(page).to have_current_path(root_path)
  end
end
