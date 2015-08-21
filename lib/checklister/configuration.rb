module Checklister
  class Configuration
    # List of all the configuration attributes stored for use within the gem
    ATTRIBUTES = [:gitlab_host, :gitlab_token]

    attr_accessor *ATTRIBUTES

    # Apply a configuration hash to a configuration instance
    #
    # @example Overide one a the configuration attributes
    #   config = Checklister::Configuration.new
    #   config.apply(gitlab_token: 'supersecret')
    #   config.gitlab_token #=> "supersecret"
    #
    # @param attributes [Hash] list of key/values toapply to the configuration
    # @return [Object] the configuration object
    #
    def apply(attributes = {})
      attributes.each_pair do |attribute, value|
        send("#{attribute}=", value)
      end
      self
    end

    def to_stdout
      to_hash.each_pair do |attribute, value|
        puts "%-20s %-50s" % ["#{attribute}:", value]
      end
    end

    def to_hash
      ATTRIBUTES.inject({}) do |hash,attr|
        hash["#{attr}"] = self.instance_variable_get("@#{attr}")
        hash
      end
    end
  end
end
