Invoice::Show::Authorized::Flow = Micro::Cases.flow(
  [Invoice::GetToken, Invoice::GetAuthentication, Invoice::Show::Authorized::GetRecord]
)
