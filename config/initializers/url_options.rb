Rails.env.on(:development) do
  Rails.application.routes.default_url_options = {
    host: 'localhost',
    protocol: :http,
    port: 3_000
  }

  config.action_mailer.default_url_options = Rails.application.routes.default_url_options
end

Rails.env.on(:test) do
  Rails.application.routes.default_url_options = {
    host: 'localhost',
    protocol: :http,
    port: 12_121
  }
end
