require "spec_helper"

describe Checklister do
  it "has a version number" do
    expect(Checklister::VERSION).not_to be nil
  end

  describe ".config" do
    it "is an instance of a the Configuration class" do
      expect(Checklister.config).to be_a Checklister::Configuration
    end

    it "defines a value"
  end

  describe ".configure" do
    it "should set a configuration parameter"
  end
end
