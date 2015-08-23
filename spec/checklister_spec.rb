require "spec_helper"

describe Checklister do
  it "has a version number" do
    expect(Checklister::VERSION).not_to be nil
  end

  context "Gem Configuration" do
    describe ".config" do
      it "is an instance of a the Configuration class" do
        expect(Checklister.config).to be_a Checklister::Configuration
      end

      it "gets a configuration value" do
        expect { Checklister.config.host }.to_not raise_error
      end
    end

    describe ".configure" do
      it "should set a configuration parameter" do
        Checklister.configure host: "example.com"
        expect(Checklister.config.host).to eq("example.com")
      end
    end
  end
end
