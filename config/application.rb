require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nestle
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Minsk'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ru
    config.encoding = "utf-8"
    # Enable escaping HTML in JSON.
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.assets.precompile += %w(home.css home.js)
    config.assets.precompile += ['ckeditor/*.js', 'ckeditor/*.css', 'ckeditor/*', '*.eot', '*.otf', '*.woff', '*.ttf', '*.svg', '*.png', '*.jpg', '*.html']

    config.assets.precompile += ['livequery.js', 'active_admin.css']

    config.assets.paths << "#{Rails.root}/app/assets/fonts"
  end
end
