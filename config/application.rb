require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fuksipassi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.available_locales = [:en, :fi]
    config.i18n.default_locale = :en

    config.assets.paths << Rails.root.join('app', 'assets', 'hero-images')

    Dir.glob("#{Rails.root}/app/assets/images/**/").each do |path|
      config.assets.paths << path
    end
  end
end
