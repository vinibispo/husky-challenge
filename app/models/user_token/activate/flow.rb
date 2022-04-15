UserToken::Activate::Flow = Micro::Cases.flow(
  [UserToken::Activate::FetchRecord,UserToken::Activate::FetchUser, UserToken::Activate]
)
