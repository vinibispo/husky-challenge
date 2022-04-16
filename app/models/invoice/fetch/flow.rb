Invoice::Fetch::Flow = Micro::Cases.flow(
  [Invoice::GetToken, Invoice::GetAuthentication, Invoice::Fetch::ListRecords]
)
