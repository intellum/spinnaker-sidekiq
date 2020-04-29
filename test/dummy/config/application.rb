require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "spinnaker/sidekiq"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    if respond_to?(:load_defaults)
      config.load_defaults Rails::VERSION::MAJOR
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
