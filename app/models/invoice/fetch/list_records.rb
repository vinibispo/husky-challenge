# list records step for fetch for invoice
class Invoice::Fetch::ListRecords < Micro::Case
  attribute :user
  attribute :params
  validates :user, kind: User
  validates :params, kind: ActionController::Parameters
  def call!
    all_invoices = user.invoices
    q = all_invoices.ransack(params[:q])
    invoices = q.result.includes(:documents_attachments)
    Success result: { invoices:, q: }
  end
end
