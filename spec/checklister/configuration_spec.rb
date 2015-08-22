require "spec_helper"

describe Checklister::Configuration do
  subject(:config) { Checklister::Configuration.new }
  let(:valid_configuration_hash) do
    { host: "gitlab.example.com", username: 'benichu', token: "supersecret" }
  end

  describe "#initialize" do
    it "defines a default service" do
      expect(config.service).to be_nil
    end

    it "defines a default host" do
      expect(config.host).to be_nil
    end

    it "defines a default username" do
      expect(config.username).to be_nil
    end

    it "defines a default host" do
      expect(config.token).to be_nil
    end
  end

  describe "#apply" do
    it "applies the passed valid attributes hash" do
      config.apply(token: "foo")
      expect(config.token).to eq("foo")
    end

    it "returns the modified configuration object" do
      config.apply(token: "bar")
      expect(config.apply.token).to eq("bar")
    end

    it "does not apply unknown attributes" do
      expect { config.apply(foo: "bar").foo }.to raise_error(NoMethodError)
    end

    it "accepts no arguments" do
      config.apply
      expect(config.token).to be_nil
    end
  end

  describe "#save" do
    it "persists the given attributes hash to the configuration file"
    it "does nothing when no arguments given"
  end

  describe "#read" do
    it "reads the configuration file and returns a hash"
  end

  describe "#to_hash" do
    before do
      config.apply valid_configuration_hash
    end

    it "returns a valid value with stringified keys" do
      expect(config.to_hash).to include("host" => valid_configuration_hash[:host],
                                        "username" => valid_configuration_hash[:username],
                                        "token" => valid_configuration_hash[:token])
    end

    it "does not return symbols keys" do
      expect(config.to_hash).to_not include host: valid_configuration_hash[:host]
    end
  end

  describe "#to_stdout" do
    it "is defined" do
      expect(config).to respond_to(:to_stdout)
    end

    it "is not blank" do
      expect(STDOUT).to receive(:puts).exactly(Checklister::Configuration::ATTRIBUTES.size).times
      config.to_stdout
    end

    it "returns nil" do
      expect(config.to_stdout).to be_nil
    end
  end
end
