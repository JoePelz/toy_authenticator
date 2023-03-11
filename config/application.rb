# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
# require "active_job/railtie"

# ActiveRecord is the database connection.
# Since we're not running SQL, we don't need this functionality
# require "active_record/railtie"

# For uploading files
# require "active_storage/engine"
require 'action_controller/railtie'

# For sending and receiving emails
# require "action_mailer/railtie"
# require "action_mailbox/engine"

# For rich text content and editing
# require "action_text/engine"
require 'action_view/railtie'

# For supporting web sockets
# require "action_cable/engine"

# For compiling and serving web assets
# require "sprockets/railtie"

require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Idp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
