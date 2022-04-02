require_relative 'helpers'
require_relative 'helpers/authentication'
RSpec.configure do |config|
  config.include Helpers::Authentication, type: :system
end
