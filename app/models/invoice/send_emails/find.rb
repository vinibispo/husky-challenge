# find module for send emails for invoice
class Invoice::SendEmails::Find < Micro::Case
  attribute :user
  attribute :params

  validates :user, kind: User
  validates :params, kind: ActionController::Parameters

  def call!
    invoice = user.invoices.find(params[:id])
    Success result: { invoice: }
  rescue ActiveRecord::RecordNotFound => e
    Failure :not_found, result: { message: e.message }
  end
end
