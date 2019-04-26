require_relative 'boot'

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ApexData
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.assets.initialize_on_precompile = false

    Raven.configure do |config|
      config.dsn = "https://94cf1bba4aa346b68dded7949ce1e116:24988c7a68304f44836d3bca4912b613@sentry.io/1447612"
    end

    config.after_initialize do
      Rails.application.load_tasks

      if ActiveRecord::Base.connection.table_exists? "flipper_gates"
        Rake::Task["keep_profiles_updated"].invoke if Flipper.enabled?(:keep_profiles_updated)
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
