require "spec_helper"

describe Checklister::Configuration do
  subject(:config) { Checklister::Configuration.new }

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
      expect(config.apply).to be_a Checklister::Configuration
    end

    it "does not apply unknown attributes" do
      expect{ config.apply(foo: "bar") }.to raise_error(NoMethodError)
    end

    it "accepts no arguments" do
      config.apply
      expect(config.gitlab_token).to be_nil
    end
  end

  describe "#to_hash"
  describe "#to_s"
end
