module Checklister
  class Configuration
    # List of all the configuration attributes stored for use within the gem
    ATTRIBUTES = [:gitlab_host, :gitlab_token]

    attr_accessor *ATTRIBUTES

    # Apply a configuration hash to a configuration instance
    #
    # @example Overide one a the configuration attributes
    #   config = Checklister.new
    #   config.apply(gitlab_token: 'supersecret')
    #   config.gitlab_token #=> "supersecret"
    #
    # @return [Object] the configuration object
    #
    def apply(attributes = {})
      attributes.each_pair do |attribute, value|
        self.send("#{attribute}=", value)
      end
      self
    end
  end
end
