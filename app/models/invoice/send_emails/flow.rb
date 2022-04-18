Invoice::SendEmails::Flow = Micro::Cases.flow(
  [Invoice::GetToken, Invoice::GetAuthentication, Invoice::SendEmails::Find, Invoice::SendEmails::ValidateEmails, Invoice::SendEmails::SendInvoiceEmail]
)
