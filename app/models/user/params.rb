# params module for user
module User::Params
  def self.to_save(params)
    params.require(:user).permit(:email).to_h
  end
end
