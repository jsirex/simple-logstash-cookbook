# frozen_string_literal: true

require 'chefspec'
require 'chefspec/berkshelf'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
Dir['./libraries/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.formatter = :documentation
  config.color = true

  # Specify the path for Chef Solo to find roles (default: [ascending search])
  # config.role_path = '/var/roles'

  # Specify the Chef log_level (default: :warn)
  # config.log_level = :info
  Ohai::Config[:log_level] = :warn

  # Specify the path to a local JSON file with Ohai data (default: nil)
  # config.path = 'ohai.json'

  config.order = :random
  config.fail_fast = true
  config.server_runner_clear_cookbooks = false
end

at_exit { ChefSpec::Coverage.report! }
