require "spec_helper"
require "./lib/page"

RSpec.describe Page do

  subject { described_class.new(File.join(settings.root, "/spec/lib/example.html")) }

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
end
