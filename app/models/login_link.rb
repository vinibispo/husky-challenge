module LoginLink
  def self.create!(email:, token:)
    url = Rails.application.routes.url_helpers.new_session_url(email:, token:)
    SignedURL.call(url, key: Rails.application.credentials.signed_url_secret)
  end

  def self.valid?(signed_url)
    return unless SignedURL.verified?(signed_url, key: Rails.application.credentials.signed_url_secret)

    uri = URI(signed_url)
    params = Rack::Utils.parse_query(uri.query)
    return unless params["email"]

    return unless params["token"]

    result = UserToken::Activate::Flow.call(token: params["token"])
    worked = false
    result.on_success do
      worked = true
    end.on_failure do
      worked = false
    end
    worked
  end
end
