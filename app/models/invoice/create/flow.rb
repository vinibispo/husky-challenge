Invoice::Create::Flow = Micro::Cases.flow(
  [Invoice::GetToken, Invoice::GetAuthentication, Invoice::Create::CreateRecord, Invoice::Create::GeneratePdf, Invoice::Create::SendInvoiceEmail]
)
