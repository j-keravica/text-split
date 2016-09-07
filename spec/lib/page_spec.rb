require "spec_helper"
require "./lib/page"

RSpec.describe Page do

  subject { described_class.new(File.join(Sinatra::Application.settings.root, "/spec/lib/example.html")) }

  describe "#text" do
    it "returns web page text" do
      expect(subject.text).to include("okay to be angry and to be kind of dark")
    end
  end

  describe "#title" do
    it "returns web page title" do
      expect(subject.title).to include("Stop Trying To Inspire Me")
    end
  end

  describe "#custom_content" do
    context "valid xpath" do
      it "returns content specified by user's xpath" do
        parsed_content = subject.custom_content("//p[@name='2201']")
        expect(parsed_content).to include("Everything happens for a reason!")
      end
    end

    context "invalid xpath" do
      it "raises an invalid path error" do
        expect { subject.custom_content("troll") }.to raise_error(Exceptions::InvalidPath)
      end
    end
  end
end
