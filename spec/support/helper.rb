require_relative 'helpers'
require_relative 'helpers/authentication'
require_relative 'helpers/i18n'
RSpec.configure do |config|
  config.include Helpers::Authentication, type: :system
  config.include Helpers::I18n
end
