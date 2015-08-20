require "checklister/version"
require "checklister/configuration"

module Checklister
  class << self
    # Keep track of the configuration values set after a configuration
    # has been applied
    #
    # @example Return a configuration value
    #   Checklister.config.foo #=> "bar"
    #
    # @return [Object] the configuration object
    #
    def config
      @config ||= Checklister::Configuration.new
    end
  end
end
