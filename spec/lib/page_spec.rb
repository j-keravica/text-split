require "spec_helper"
require "./lib/page"

RSpec.describe Page do

  let(:web_page) { File.join(Sinatra::Application.settings.root, "/spec/lib/example.html") }

  describe "#title" do
    before do
      @page = described_class.new(web_page, "")
    end

    it "returns web page title" do
      expect(@page.title).to include("Stop Trying To Inspire Me")
    end
  end

  describe "#content" do
    before do
      @page = described_class.new(web_page, "")
    end

    it "returns web page text" do
      expect(@page.content).to include("okay to be angry and to be kind of dark")
    end
  end

  describe "#custom_content" do
    context "valid xpath" do
      before do
        @page = described_class.new(web_page, "//p[@name='2201']")
      end

      it "returns content specified by user's xpath" do
        parsed_content =@page.custom_content
        expect(parsed_content).to include("Everything happens for a reason!")
      end
    end

    context "invalid xpath" do
      before do
        @page = described_class.new(web_page, "troll")
      end

      it "raises an invalid path error" do
        expect { @page.custom_content }.to raise_error(Exceptions::InvalidPath)
      end
    end
  end
end
