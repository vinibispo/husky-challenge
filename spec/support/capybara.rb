Capybara.configure do |config|
  config.server_port = Rails.application.routes.default_url_options[:port]
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end
end
