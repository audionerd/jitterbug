require 'jitterbug'

# ActionController::Base.extend Jitterbug::ControllerMixin

RAILS_DEFAULT_LOGGER.info("** Jitterbug initialized with these settings:\n#{Jitterbug::Config.settings.to_yaml}") if defined?(RAILS_DEFAULT_LOGGER)
