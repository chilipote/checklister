require "spec_helper"

describe Checklister::Configuration do
  subject(:config) { Checklister::Configuration.new }
  let(:valid_configuration_hash) do
    { gitlab_host: "gitlab.example.com", gitlab_token: "supersecret" }
  end

  describe "#initialize" do
    it "defines a default gitlab_host" do
      expect(config.gitlab_host).to be_nil
    end

    it "defines a default gitlab_host" do
      expect(config.gitlab_token).to be_nil
    end
  end

  describe "#apply" do
    it "applies the passed valid attributes hash" do
      config.apply(gitlab_token: "foo")
      expect(config.gitlab_token).to eq("foo")
    end

    it "returns the modified configuration object" do
      config.apply(gitlab_token: "bar")
      expect(config.apply.gitlab_token).to eq("bar")
    end

    it "does not apply unknown attributes" do
      expect { config.apply(foo: "bar") }.to raise_error(NoMethodError)
    end

    it "accepts no arguments" do
      config.apply
      expect(config.gitlab_token).to be_nil
    end
  end

  describe "#to_hash" do
    before do
      config.apply valid_configuration_hash
    end

    it "returns a valid value with stringified keys" do
      expect(config.to_hash).to include("gitlab_host" => valid_configuration_hash[:gitlab_host],
                                        "gitlab_token" => valid_configuration_hash[:gitlab_token])
    end

    it "does not return symbols keys" do
      expect(config.to_hash).to_not include gitlab_host: valid_configuration_hash[:gitlab_host]
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
  end
end
