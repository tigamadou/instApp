require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Friendly
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    
    config.load_defaults 5.2
    config.exceptions_app = self.routes # Add this line
    config.generators do |g|
      g.assets false
      g.helper false
    end
  end
end
