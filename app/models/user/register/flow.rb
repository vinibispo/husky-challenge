User::Register::Flow = Micro::Cases.flow(
  [User::Register::NormalizeParams, User::Register::FindRecord, User::Register::RegenerateToken, User::Register::CreateRecord, User::Register::SendTokenEmail]
)
