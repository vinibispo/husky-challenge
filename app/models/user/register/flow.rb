User::Register::Flow = Micro::Cases.flow(
  [User::Register::NormalizeParams, User::Register::FindRecord, User::Register::CreateRecord, User::Register::GenerateToken, User::Register::SendTokenEmail]
)
