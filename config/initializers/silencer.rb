require 'silencer/logger'

Rails.application.configure do
  config.middleware.swap(
    Rails::Rack::Logger,
    Silencer::Logger,
    config.log_tags,
    get: [%r{^(?!/api/)}]
  )
end
