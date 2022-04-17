Invoice::New::Flow = Micro::Cases.flow(
  [Invoice::GetToken, Invoice::GetAuthentication, Invoice::New::NewObject]
)
