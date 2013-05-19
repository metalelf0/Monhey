require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Finanze
  class Application < Rails::Application
    config.encoding = "utf-8"

    config.filter_parameters += [:password]
    config.assets.initialize_on_precompile = false

    config.assets.enabled = true
    config.assets.version = '1.0'
    config.autoload_paths += [ "#{config.root}/lib" ]
  end
end
