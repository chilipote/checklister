module Checklister
  # Apply and hold every configuration options required by *checklister* to
  # function properly.
  #
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
      prepared_attributes = prepare_attributes attributes
      prepared_attributes.each_pair do |attribute, value|
        send("#{attribute}=", value)
      end
      self
    end

    # The configuration instance formatted as a stringified hash
    #
    # @example Overide one a the configuration attributes
    #   config = Checklister::Configuration.new
    #   config.to_hash #=> { "gitlab_host" => "gitlab.example.com", ..., "gitlab_token" => "supersecret" }
    #
    # @return [Hash] the configuration object as a Hash
    #
    def to_hash
      ATTRIBUTES.inject({}) do |hash, attr|
        hash["#{attr}"] = instance_variable_get("@#{attr}")
        hash
      end
    end

    # Write a configuration summary to STDOUT, useful for output in the CLI
    #
    def to_stdout
      to_hash.each_pair do |attribute, value|
        puts "%-20s %-50s" % ["#{attribute}:", value]
      end
      nil
    end

    private

    def prepare_attributes(attributes)
      # Convert string keys to symbols
      symboled_attributes = attributes.inject({}) do |memo,(k,v)|
        memo[k.to_sym] = v
        memo
      end
      # Cleanup user_attributes from unwanted, nil and duplicate options
      symboled_attributes.select { |key,_| ATTRIBUTES.include? key }
                         .delete_if { |_, v| v.nil? }
    end
  end
end
