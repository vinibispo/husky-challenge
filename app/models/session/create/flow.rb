Session::Create::Flow = Micro::Cases.flow(
  [Session::Create::GetToken, Session::Create::GetRecord]
)
